:- dynamic student/3.
:- dynamic course/5.
:- dynamic room/4.
% Rooms
room(z23, 110, [8,9,10,11,12,13,14,15,16,17], [projector, smartboard, nothandicapped]).
room(z11, 120, [8,9,10,11,12,13,14,15,16,17], [projector, smartboard, handicapped]).
room(z06, 80, [8,9,10,11,12,13,14,15,16,17], [handicapped]).

% Courses
course(222, fatiherdogan, 110, [11,12], z23).
course(341, yakupgenc, 120, [11,12], z11).
course(361, yakupgenc, 110, [14,15], z23).
course(101, mehmetgokturk, 80, [13,14], z06).

% Instructors
instructor( fatiherdogan, [222]).
instructor( yakupgenc, [341], smartboard).
instructor( mehmetgokturk, [101], projector).

% Students
student(2614, [222, 341], nothandicapped).
student(2606, [341], nothandicapped).
student(2631, [101], nothandicapped).
student(2681, [101], handicapped).

% add a new room to the system
add_room(ID, Capacity, Hours, Equipment) :-
    assert( room(ID, Capacity, Hours, Equipment)).

% add a new course to the system
add_course(ID, Instructor, Capacity, Hours, Room) :-
    assert(course(ID, Instructor, Capacity, Hours, Room)).

% add a new student to the system
add_student(ID, Courses, Handicapped) :-
    assert(student(ID, Courses, Handicapped)).

not_full(Room) :-
    room(Room, Capacity, _, _),
    findall(Student, (student(Student, Courses, _), member(Course, Courses), course(Course, _, _, _, Room)), Students),
    length(Students, NumStudents),
    NumStudents < Capacity.

conflict(Course1, Course2) :-
    course(Course1, _, _, Times1, _),
    course(Course2, _, _, Times2, _),
    member(Time, Times1),
    member(Time, Times2).

assignable_room(Course, Room) :-
    not_full(Room),
    course(Course, _, _, Times, _),
    room(Room, _, AvailableTimes, _),
    member(Time, Times),
    member(Time, AvailableTimes).

instructable_courses(Room) :-
    not_full(Room),
    findall(Course, course(Course, _, _, Times, Room), Courses),
    write(Courses).

enrollwithcourse(Student, Course) :-
    student(Student, _, Handicap_compatiable),
    course(Course, _, _, _, Room),
    not_full(Room),
    room(Room, _, _, Features),
    member(Handicap_compatiable, Features).

enrollable_courses(Studentid) :-
    student(Studentid, _, Handicap),
    findall(Course, (   course(Course, _, _, _, Room), 
                        not_full(Room), 
    (   Handicap = handicapped 
        -> handicap_compatible(Room) 
        ; true)), 
        Courses),
    write(Courses).

handicap_compatible(Roomid) :-
    room(Roomid, _, _, Features),
    member(handicapped, Features).
