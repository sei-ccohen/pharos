% A module for reporting the results of object matching.  This probably won't be used in the
% production tool, but it should be useful for interactive debugging of the Prolog
% infrastructure, and perhaps more importantly, it serves to define what an "answer" is for
% when it comes time to import the results back into OOAnalyzer.

:- import maplist/2 from swi.

writeHelper([]).
writeHelper([H|[]]) :-
    writeHex(H).
writeHelper([H|T]) :-
    writeHex(H), write(', '), writeHelper(T).
writeList(L) :-
    write('['), writeHelper(L), write(']').

% This definition of progress is for when we're NOT running from within OOAnalyzer, which is
% probably the same circumstances where we want this reporting module.
progress(N) :-
  debug('There are '), debug(N), debugln(' known facts.').

% In the OOAnalyzer binary, these are passed to a proper Pharos logging stream.  Here we're
% just going to pass them to debug for a while longer at least.  We should really convert the
% boolean that enables and disables debugging into a desired log level, and user it here as
% well.
log(Importance, Message) :-
    debug(Message).
logln(Importance, Message) :-
    debugln(Message).

% ============================================================================================
% Virtual Function Tables
% ============================================================================================

reportFinalVFTable((V, C, L, A, N)) :-
    %finalVFTable(V, C, L, A, N),
    write('finalVFTable('),
    writeHex(V), write(', '),
    writeHex(C), write(', '),
    writeHex(L), write(', '),
    writeHex(A), write(', '),
    write('\''), writeHex(N), write('\''), writeln(').').

reportVFTables :-
    setof((V, C, L, A, N), finalVFTable(V, C, L, A, N), Set),
    maplist(reportFinalVFTable, Set).
reportVFTables :- true.

reportFinalVFTableEntry((A, O, M)) :-
    write('finalVFTableEntry('),
    writeHex(A), write(', '),
    writeHex(O), write(', '),
    writeHex(M), writeln(').').

reportVFTableEntries :-
    setof((A, O, M), finalVFTableEntry(A, O, M), Set),
    maplist(reportFinalVFTableEntry, Set).
reportVFTableEntries :- true.

% ============================================================================================
% Virtual Base Tables
% ============================================================================================

reportFinalVBTable((V, C, S, O)) :-
    %finalVBTable(V, C, S, O),
    write('finalVBTable('),
    writeHex(V), write(', '),
    writeHex(C), write(', '),
    writeHex(S), write(', '),
    writeHex(O), writeln(').').

reportVBTables :-
    setof((V, C, S, O), finalVBTable(V, C, S, O), Set),
    maplist(reportFinalVBTable, Set).
reportVBTables :- true.

reportFinalVBTableEntry((A, O, V)) :-
    write('finalVBTableEntry('),
    writeHex(A), write(', '),
    writeHex(O), write(', '),
    writeHex(V), writeln(').').

reportVBTableEntries :-
    setof((A, O, V), finalVBTableEntry(A, O, V), Set),
    maplist(reportFinalVBTableEntry, Set).
reportVBTableEntries :- true.

% ============================================================================================
% Class Definitions
% ============================================================================================

reportFinalClass((C, V, S, L, R, M)) :-
    %finalClass(C, V, S, L, R, M),
    write('finalClass('),
    writeHex(C), write(', '),
    writeHex(V), write(', '),
    writeHex(S), write(', '),
    writeHex(L), write(', '),
    writeHex(R), write(', '),
    writeList(M), writeln(').').

reportClasses :-
    setof((C, V, S, L, R, M), finalClass(C, V, S, L, R, M), Set),
    maplist(reportFinalClass, Set).
reportClasses :- true.

% ============================================================================================
% Resolved Virtual Function Calls
% ============================================================================================

reportFinalResolvedVirtualCall((I, V, T)) :-
    write('finalResolvedVirtualCall('),
    writeHex(I), write(', '),
    writeHex(V), write(', '),
    writeHex(T), writeln(').').

reportResolvedVirtualCalls :-
    setof((I, V, T), finalResolvedVirtualCall(I, V, T), Set),
    maplist(reportFinalResolvedVirtualCall, Set).
reportResolvedVirtualCalls :- true.

% ============================================================================================
% Embedded objects.
% ============================================================================================

reportFinalEmbeddedObject((C, O, E, X)) :-
    %finalEmbeddedObject(C, O, E, X),
    write('finalEmbeddedObject('),
    writeHex(C), write(', '),
    writeHex(O), write(', '),
    writeHex(E), write(', '),
    writeHex(X), writeln(').').

reportEmbeddedObjects :-
    setof((C, O, E, X), finalEmbeddedObject(C, O, E, X), Set),
    maplist(reportFinalEmbeddedObject, Set).
reportEmbeddedObjects :- true.

% ============================================================================================
% Inheritance relationships
% ============================================================================================

reportFinalInheritance((D, B, O, C, V)) :-
    %finalInheritance(D, B, O, C, V),
    write('finalInheritance('),
    writeHex(D), write(', '),
    writeHex(B), write(', '),
    writeHex(O), write(', '),
    writeHex(C), write(', '),
    writeHex(V), writeln(').').

reportInheritances :-
    setof((D, B, O, C, V), finalInheritance(D, B, O, C, V), Set),
    maplist(reportFinalInheritance, Set).
reportInheritances :- true.

% ============================================================================================
% Definitions of members on classes.
% ============================================================================================

reportFinalMember((C, O, S, L)) :-
    % this call to finalMember is redundant
    % finalMember(C, O, S, L),
    write('finalMember('),
    writeHex(C), write(', '),
    writeHex(O), write(', '),
    writeList(S), write(', '),
    writeHex(L), writeln(').').

reportMembers :-
    setof((C, O, S, L), finalMember(C, O, S, L), Set),
    maplist(reportFinalMember, Set).
reportMembers :- true.

% ============================================================================================
% Definitions of members on classes.
% ============================================================================================

reportFinalMemberAccess((C, O, S, E)) :-
    write('finalMemberAccess('),
    writeHex(C), write(', '),
    writeHex(O), write(', '),
    writeHex(S), write(', '),
    writeList(E), writeln(').').

reportMemberAccesses :-
    setof((C, O, S, E), finalMemberAccess(C, O, S, E), Set),
    maplist(reportFinalMemberAccess, Set).
reportMemberAccesses :- true.

% ============================================================================================
% Method Properties
% ============================================================================================

reportFinalMethodProperty((M, P, C)) :-
    write('finalMethodProperty('),
    writeHex(M), write(', '),
    writeHex(P), write(', '),
    writeHex(C), writeln(').').

reportMethodProperties :-
    setof((M, P, C), finalMethodProperty(M, P, C), Set),
    maplist(reportFinalMethodProperty, Set).
reportMethodProperties :- true.

% ============================================================================================
% Some thunk analysis (debugging?)
% ============================================================================================

reportEventualThunk((T, F)) :-
    write('eventualThunk('),
    writeHex(T), write(', '),
    writeHex(F), writeln(').').

reportEventualThunks :-
    setof((T, F), eventualThunk(T, F), Set),
    maplist(reportEventualThunk, Set).
reportEventualThunks :- true.

reportUniqueThunk((T, F)) :-
    write('uniqueThunk('),
    writeHex(T), write(', '),
    writeHex(F), writeln(').').

reportUniqueThunks :-
    setof((T, F), uniqueThunk(T, F), Set),
    maplist(reportUniqueThunk, Set).
reportUniqueThunks :- true.

reportConflictedThunk((T, O, F)) :-
    write('conflictedThunk('),
    writeHex(T), write(', '),
    writeHex(O), write(', '),
    writeHex(F), writeln(').').

reportConflictedThunks :-
    setof((T, O, F), conflictedThunk(T, O, F), Set),
    maplist(reportConflictedThunk, Set).
reportConflictedThunks :- true.

% ============================================================================================
% The main reporting rule.
% ============================================================================================

reportResults :-
    reportGuessedStatistics,
    writeln('% Prolog results autogenerated by OOAnalyzer.'),
    reportVFTables,
    reportVFTableEntries,
    reportVBTables,
    reportVBTableEntries,
    reportClasses,
    reportResolvedVirtualCalls,
    reportEmbeddedObjects,
    reportInheritances,
    reportMembers,
    reportMemberAccesses,
    reportMethodProperties,
    %reportEventualThunks,
    %reportUniqueThunks,
    %reportConflictedThunks,
    % Cory would like for this line to go to stderr?
    writeln('% Object detection reporting complete.').

% ============================================================================================
% Rules for counting guesses at the end of execution.
% ============================================================================================

:- import length/2 from basics.

% Woot! Cory figured it out to count arbitary predicates all by himself! ;-)
count(Pred/Arity, N) :-
    functor(OldTerm, Pred, Arity),
    findall(1, OldTerm, L),
    length(L, N).

% Print how many conclusions were guessed versus how many were reasoned.  We could also report
% the actual specific guesssed facts if we wanted.
reportGuessedStatistics :-
    count(guessedMethod/1, GM), count(factMethod/1, FM),
    count(guessedNOTMethod/1, GNM), count(factNOTMethod/1, FNM),
    debug('Guessed methods '), debug(GM), debug(' of '), debug(FM),
    debug(', NOT: '), debug(GNM), debug(' of '), debugln(FNM),

    count(guessedConstructor/1, GC), count(factConstructor/1, FC),
    count(guessedNOTConstructor/1, GNC), count(factNOTConstructor/1, FNC),
    debug('Guessed constructors '), debug(GC), debug(' of '), debug(FC),
    debug(', NOT: '), debug(GNC), debug(' of '), debugln(FNC),

    count(guessedRealDestructor/1, GRD), count(factRealDestructor/1, FRD),
    count(guessedNOTRealDestructor/1, GNRD), count(factNOTRealDestructor/1, FNRD),
    debug('Guessed real destructors '), debug(GRD), debug(' of '), debug(FRD),
    debug(', NOT: '), debug(GNRD), debug(' of '), debugln(FNRD),

    count(guessedDeletingDestructor/1, GDD), count(factDeletingDestructor/1, FDD),
    count(guessedNOTDeletingDestructor/1, GNDD), count(factNOTDeletingDestructor/1, FNDD),
    debug('Guessed deleting destructors '), debug(GDD), debug(' of '), debug(FDD),
    debug(', NOT: '), debug(GNDD), debug(' of '), debugln(FNDD),

    count(guessedVirtualFunctionCall/5, GVFC), count(factVirtualFunctionCall/5, FVFC),
    count(guessedNOTVirtualFunctionCall/5, GNVFC), count(factNOTVirtualFunctionCall/5, FNVFC),
    debug('Guessed virtual function calls '), debug(GVFC), debug(' of '), debug(FVFC),
    debug(', NOT: '), debug(GNVFC), debug(' of '), debugln(FNVFC),

    count(guessedVFTable/1, GVFT), count(factVFTable/1, FVFT),
    count(guessedNOTVFTable/1, GNVFT), count(factNOTVFTable/1, FNVFT),
    debug('Guessed virtual function tables '), debug(GVFT), debug(' of '), debug(FVFT),
    debug(', NOT: '), debug(GNVFT), debug(' of '), debugln(FNVFT),

    count(guessedVBTable/1, GVBT), count(factVBTable/1, FVBT),
    count(guessedNOTVBTable/1, GNVBT), count(factNOTVBTable/1, FNVBT),
    debug('Guessed virtual base tables '), debug(GVBT), debug(' of '), debug(FVBT),
    debug(', NOT: '), debug(GNVBT), debug(' of '), debugln(FNVBT),

    count(guessedVFTableEntry/3, GVFTE), count(factVFTableEntry/3, FVFTE),
    count(guessedNOTVFTableEntry/3, GNVFTE), count(factNOTVFTableEntry/3, FNVFTE),
    debug('Guessed virtual function table entries '), debug(GVFTE), debug(' of '), debug(FVFTE),
    debug(', NOT: '), debug(GNVFTE), debug(' of '), debugln(FNVFTE),

    count(guessedDerivedClass/3, GDC), count(factDerivedClass/3, FDC),
    count(guessedNOTDerivedClass/3, GNDC), count(factNOTDerivedClass/3, FNDC),
    debug('Guessed derived classes '), debug(GDC), debug(' of '), debug(FDC),
    debug(', NOT: '), debug(GNDC), debug(' of '), debugln(FNDC),

    count(guessedEmbeddedObject/3, GEO), count(factEmbeddedObject/3, FEO),
    count(guessedNOTEmbeddedObject/3, GNEO), count(factNOTEmbeddedObject/3, FNEO),
    debug('Guessed embedded objects '), debug(GEO), debug(' of '), debug(FEO),
    debug(', NOT: '), debug(GNEO), debug(' of '), debugln(FNEO),

    count(guessedClassHasUnknownBase/1, GUBC), count(factClassHasUnknownBase/1, FUBC),
    count(guessedClassHasNoBase/1, GNBC), count(factClassHasNoBase/1, FNBC),
    debug('Guessed has a base class '), debug(GUBC), debug(' of '), debug(FUBC),
    debug(', NOT: '), debug(GNBC), debug(' of '), debugln(FNBC),

    %% count(guessedMergeClasses/2, GMC), count(factMergeClasses/2, FMC),
    %% count(guessedNOTMergeClasses/2, GNMC), count(factNOTMergeClasses/2, FNMC),
    %% debug('Guessed class mergers '), debug(GMC), debug(' of '), debug(FMC),
    %% debug(', NOT: '), debug(GNMC), debug(' of '), debugln(FNMC),

    true.

/* Local Variables:   */
/* mode: prolog       */
/* fill-column:    95 */
/* comment-column: 0  */
/* End:               */
