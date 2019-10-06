{-# OPTIONS_GHC -w #-}
module Main where
import Data.Char
import Data.List
import Lexer
import qualified Data.Array as Happy_Data_Array
import qualified Data.Bits as Bits
import Control.Applicative(Applicative(..))
import Control.Monad (ap)

-- parser produced by Happy Version 1.19.9

data HappyAbsSyn t4 t5 t6 t7 t8 t9 t10 t11 t12 t13 t14 t15
	= HappyTerminal (Token)
	| HappyErrorToken Int
	| HappyAbsSyn4 t4
	| HappyAbsSyn5 t5
	| HappyAbsSyn6 t6
	| HappyAbsSyn7 t7
	| HappyAbsSyn8 t8
	| HappyAbsSyn9 t9
	| HappyAbsSyn10 t10
	| HappyAbsSyn11 t11
	| HappyAbsSyn12 t12
	| HappyAbsSyn13 t13
	| HappyAbsSyn14 t14
	| HappyAbsSyn15 t15

happyExpList :: Happy_Data_Array.Array Int Int
happyExpList = Happy_Data_Array.listArray (0,196) ([32768,0,0,0,0,0,8192,0,0,0,0,0,4096,0,0,0,0,0,0,0,0,0,0,0,29440,0,2560,16,0,4,64,0,0,0,0,0,0,0,16384,0,0,0,0,0,0,0,0,0,0,0,0,0,1024,0,0,0,0,0,0,0,0,0,0,0,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,0,1024,32768,28,0,1026,0,0,8192,7,32768,256,0,0,0,0,8192,4,0,0,0,0,0,1,0,0,0,0,0,0,16384,0,0,0,0,0,16384,0,0,0,0,0,0,0,0,0,16,0,0,0,0,0,1,0,0,49152,0,8192,0,0,72,0,0,0,0,0,0,29184,0,2560,16,0,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,15360,0,0,0,0,0,0,0,0,0,0,0,0,0,192,0,32,0,18432,0,48,0,8,0,4608,0,0,0,0,0,0,0,1792,0,0,0,0,0,0,32768,0,0,0,0,0,16384,0,0,0,0,0,0,0,0,4,0,0,0,0,0,0,0,0,128,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,256,0,0,0,0,0,64,0,0,0,48,0,8,0,4608,0,12,0,2,0,1152,0,3,32768,0,0,288,49152,0,8192,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	])

{-# NOINLINE happyExpListPerState #-}
happyExpListPerState st =
    token_strs_expected
  where token_strs = ["error","%dummy","%start_midnight","S","Seq","Instr","Declar","Type","TComp","LValue","RValue","Slice","ExpBool","BoolLit","BoolAux","space","end","moon","new","full","planet","cloud","star","blackhole","cosmos","constellation","cluster","quasar","nebula","galaxy","ufo","comet","satellite","terraform","print","read","around","range","pop","add","bigbang","if","elseif","else","unless","while","until","orbit","arroba","'('","')'","'['","']'","'{'","'}'","'..'","'.'","','","';'","':'","'~'","'+='","'+'","'-='","'-'","'*='","'*'","'^='","'^'","'//='","'//'","'/='","'/'","'%='","'%'","'->'","'>='","'>'","'<='","'<'","'&&'","'&'","'||'","'|'","'=='","'\9516\188='","'='","'\9516\188'","str","chr","id","float","int","%eof"]
        bit_start = st * 94
        bit_end = (st + 1) * 94
        read_bit = readArrayBit happyExpList
        bits = map read_bit [bit_start..bit_end - 1]
        bits_indexed = zip bits [0..93]
        token_strs_expected = concatMap f bits_indexed
        f (False, _) = []
        f (True, nr) = [token_strs !! nr]

action_0 (16) = happyShift action_4
action_0 (4) = happyGoto action_3
action_0 _ = happyFail (happyExpListPerState 0)

action_1 (16) = happyShift action_2
action_1 _ = happyFail (happyExpListPerState 1)

action_2 (17) = happyShift action_11
action_2 _ = happyFail (happyExpListPerState 2)

action_3 (94) = happyAccept
action_3 _ = happyFail (happyExpListPerState 3)

action_4 (17) = happyShift action_11
action_4 (18) = happyShift action_12
action_4 (21) = happyShift action_13
action_4 (22) = happyShift action_14
action_4 (23) = happyShift action_15
action_4 (50) = happyShift action_16
action_4 (52) = happyShift action_17
action_4 (61) = happyShift action_18
action_4 (91) = happyShift action_19
action_4 (5) = happyGoto action_5
action_4 (6) = happyGoto action_6
action_4 (7) = happyGoto action_7
action_4 (8) = happyGoto action_8
action_4 (9) = happyGoto action_9
action_4 (10) = happyGoto action_10
action_4 _ = happyFail (happyExpListPerState 4)

action_5 (17) = happyShift action_29
action_5 _ = happyFail (happyExpListPerState 5)

action_6 (59) = happyShift action_28
action_6 _ = happyReduce_3

action_7 _ = happyReduce_6

action_8 (91) = happyShift action_27
action_8 _ = happyFail (happyExpListPerState 8)

action_9 _ = happyReduce_13

action_10 (87) = happyShift action_26
action_10 _ = happyFail (happyExpListPerState 10)

action_11 _ = happyReduce_1

action_12 _ = happyReduce_12

action_13 _ = happyReduce_9

action_14 _ = happyReduce_10

action_15 _ = happyReduce_11

action_16 (50) = happyShift action_16
action_16 (91) = happyShift action_19
action_16 (10) = happyGoto action_25
action_16 _ = happyFail (happyExpListPerState 16)

action_17 (18) = happyShift action_12
action_17 (21) = happyShift action_13
action_17 (22) = happyShift action_14
action_17 (23) = happyShift action_15
action_17 (52) = happyShift action_17
action_17 (61) = happyShift action_18
action_17 (8) = happyGoto action_24
action_17 (9) = happyGoto action_9
action_17 _ = happyFail (happyExpListPerState 17)

action_18 (18) = happyShift action_12
action_18 (21) = happyShift action_13
action_18 (22) = happyShift action_14
action_18 (23) = happyShift action_15
action_18 (52) = happyShift action_17
action_18 (61) = happyShift action_18
action_18 (8) = happyGoto action_23
action_18 (9) = happyGoto action_9
action_18 _ = happyFail (happyExpListPerState 18)

action_19 (52) = happyShift action_21
action_19 (57) = happyShift action_22
action_19 (12) = happyGoto action_20
action_19 _ = happyReduce_18

action_20 (57) = happyShift action_44
action_20 _ = happyReduce_22

action_21 (89) = happyShift action_43
action_21 _ = happyFail (happyExpListPerState 21)

action_22 (91) = happyShift action_42
action_22 _ = happyFail (happyExpListPerState 22)

action_23 _ = happyReduce_17

action_24 (53) = happyShift action_41
action_24 _ = happyFail (happyExpListPerState 24)

action_25 (51) = happyShift action_40
action_25 _ = happyFail (happyExpListPerState 25)

action_26 (19) = happyShift action_36
action_26 (20) = happyShift action_37
action_26 (50) = happyShift action_38
action_26 (88) = happyShift action_39
action_26 (91) = happyShift action_19
action_26 (10) = happyGoto action_31
action_26 (11) = happyGoto action_32
action_26 (13) = happyGoto action_33
action_26 (14) = happyGoto action_34
action_26 (15) = happyGoto action_35
action_26 _ = happyFail (happyExpListPerState 26)

action_27 _ = happyReduce_8

action_28 (18) = happyShift action_12
action_28 (21) = happyShift action_13
action_28 (22) = happyShift action_14
action_28 (23) = happyShift action_15
action_28 (50) = happyShift action_16
action_28 (52) = happyShift action_17
action_28 (61) = happyShift action_18
action_28 (91) = happyShift action_19
action_28 (5) = happyGoto action_30
action_28 (6) = happyGoto action_6
action_28 (7) = happyGoto action_7
action_28 (8) = happyGoto action_8
action_28 (9) = happyGoto action_9
action_28 (10) = happyGoto action_10
action_28 _ = happyReduce_4

action_29 _ = happyReduce_2

action_30 _ = happyReduce_5

action_31 (81) = happyReduce_43
action_31 (82) = happyReduce_43
action_31 (83) = happyReduce_43
action_31 (84) = happyReduce_43
action_31 _ = happyReduce_24

action_32 _ = happyReduce_7

action_33 _ = happyReduce_25

action_34 (81) = happyReduce_42
action_34 (82) = happyReduce_42
action_34 (83) = happyReduce_42
action_34 (84) = happyReduce_42
action_34 _ = happyReduce_28

action_35 (81) = happyShift action_55
action_35 (82) = happyShift action_56
action_35 (83) = happyShift action_57
action_35 (84) = happyShift action_58
action_35 _ = happyFail (happyExpListPerState 35)

action_36 _ = happyReduce_40

action_37 _ = happyReduce_41

action_38 (19) = happyShift action_36
action_38 (20) = happyShift action_37
action_38 (50) = happyShift action_38
action_38 (88) = happyShift action_39
action_38 (91) = happyShift action_19
action_38 (10) = happyGoto action_53
action_38 (13) = happyGoto action_54
action_38 (14) = happyGoto action_34
action_38 (15) = happyGoto action_35
action_38 _ = happyFail (happyExpListPerState 38)

action_39 (19) = happyShift action_36
action_39 (20) = happyShift action_37
action_39 (50) = happyShift action_38
action_39 (88) = happyShift action_39
action_39 (91) = happyShift action_19
action_39 (10) = happyGoto action_51
action_39 (13) = happyGoto action_52
action_39 (14) = happyGoto action_34
action_39 (15) = happyGoto action_35
action_39 _ = happyFail (happyExpListPerState 39)

action_40 _ = happyReduce_23

action_41 (27) = happyShift action_48
action_41 (28) = happyShift action_49
action_41 (29) = happyShift action_50
action_41 _ = happyFail (happyExpListPerState 41)

action_42 (52) = happyShift action_21
action_42 (12) = happyGoto action_47
action_42 _ = happyReduce_19

action_43 (53) = happyShift action_46
action_43 _ = happyFail (happyExpListPerState 43)

action_44 (91) = happyShift action_45
action_44 _ = happyFail (happyExpListPerState 44)

action_45 _ = happyReduce_21

action_46 (52) = happyShift action_21
action_46 (12) = happyGoto action_68
action_46 _ = happyReduce_26

action_47 _ = happyReduce_20

action_48 _ = happyReduce_14

action_49 _ = happyReduce_15

action_50 _ = happyReduce_16

action_51 (81) = happyReduce_43
action_51 (82) = happyReduce_43
action_51 (83) = happyReduce_43
action_51 (84) = happyReduce_43
action_51 _ = happyReduce_38

action_52 _ = happyReduce_33

action_53 (51) = happyShift action_40
action_53 _ = happyReduce_43

action_54 (51) = happyShift action_67
action_54 _ = happyFail (happyExpListPerState 54)

action_55 (19) = happyShift action_36
action_55 (20) = happyShift action_37
action_55 (50) = happyShift action_38
action_55 (88) = happyShift action_39
action_55 (91) = happyShift action_19
action_55 (10) = happyGoto action_65
action_55 (13) = happyGoto action_66
action_55 (14) = happyGoto action_34
action_55 (15) = happyGoto action_35
action_55 _ = happyFail (happyExpListPerState 55)

action_56 (19) = happyShift action_36
action_56 (20) = happyShift action_37
action_56 (50) = happyShift action_38
action_56 (88) = happyShift action_39
action_56 (91) = happyShift action_19
action_56 (10) = happyGoto action_63
action_56 (13) = happyGoto action_64
action_56 (14) = happyGoto action_34
action_56 (15) = happyGoto action_35
action_56 _ = happyFail (happyExpListPerState 56)

action_57 (19) = happyShift action_36
action_57 (20) = happyShift action_37
action_57 (50) = happyShift action_38
action_57 (88) = happyShift action_39
action_57 (91) = happyShift action_19
action_57 (10) = happyGoto action_61
action_57 (13) = happyGoto action_62
action_57 (14) = happyGoto action_34
action_57 (15) = happyGoto action_35
action_57 _ = happyFail (happyExpListPerState 57)

action_58 (19) = happyShift action_36
action_58 (20) = happyShift action_37
action_58 (50) = happyShift action_38
action_58 (88) = happyShift action_39
action_58 (91) = happyShift action_19
action_58 (10) = happyGoto action_59
action_58 (13) = happyGoto action_60
action_58 (14) = happyGoto action_34
action_58 (15) = happyGoto action_35
action_58 _ = happyFail (happyExpListPerState 58)

action_59 (81) = happyReduce_43
action_59 (82) = happyReduce_43
action_59 (83) = happyReduce_43
action_59 (84) = happyReduce_43
action_59 _ = happyReduce_37

action_60 _ = happyReduce_32

action_61 (81) = happyReduce_43
action_61 (82) = happyReduce_43
action_61 (83) = happyReduce_43
action_61 (84) = happyReduce_43
action_61 _ = happyReduce_36

action_62 _ = happyReduce_31

action_63 (81) = happyReduce_43
action_63 (82) = happyReduce_43
action_63 (83) = happyReduce_43
action_63 (84) = happyReduce_43
action_63 _ = happyReduce_35

action_64 _ = happyReduce_30

action_65 (81) = happyReduce_43
action_65 (82) = happyReduce_43
action_65 (83) = happyReduce_43
action_65 (84) = happyReduce_43
action_65 _ = happyReduce_34

action_66 _ = happyReduce_29

action_67 (81) = happyReduce_44
action_67 (82) = happyReduce_44
action_67 (83) = happyReduce_44
action_67 (84) = happyReduce_44
action_67 _ = happyReduce_39

action_68 _ = happyReduce_27

happyReduce_1 = happySpecReduce_2  4 happyReduction_1
happyReduction_1 _
	_
	 =  HappyAbsSyn4
		 (Root Empty
	)

happyReduce_2 = happySpecReduce_3  4 happyReduction_2
happyReduction_2 _
	(HappyAbsSyn5  happy_var_2)
	_
	 =  HappyAbsSyn4
		 (Root happy_var_2
	)
happyReduction_2 _ _ _  = notHappyAtAll 

happyReduce_3 = happySpecReduce_1  5 happyReduction_3
happyReduction_3 (HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn5
		 (One happy_var_1
	)
happyReduction_3 _  = notHappyAtAll 

happyReduce_4 = happySpecReduce_2  5 happyReduction_4
happyReduction_4 _
	(HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn5
		 (One happy_var_1
	)
happyReduction_4 _ _  = notHappyAtAll 

happyReduce_5 = happySpecReduce_3  5 happyReduction_5
happyReduction_5 (HappyAbsSyn5  happy_var_3)
	_
	(HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn5
		 (Many happy_var_1 happy_var_3
	)
happyReduction_5 _ _ _  = notHappyAtAll 

happyReduce_6 = happySpecReduce_1  6 happyReduction_6
happyReduction_6 (HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn6
		 (happy_var_1
	)
happyReduction_6 _  = notHappyAtAll 

happyReduce_7 = happySpecReduce_3  6 happyReduction_7
happyReduction_7 (HappyAbsSyn11  happy_var_3)
	_
	(HappyAbsSyn10  happy_var_1)
	 =  HappyAbsSyn6
		 (Asig happy_var_1 happy_var_3
	)
happyReduction_7 _ _ _  = notHappyAtAll 

happyReduce_8 = happySpecReduce_2  7 happyReduction_8
happyReduction_8 (HappyTerminal (TkId happy_var_2))
	(HappyAbsSyn8  happy_var_1)
	 =  HappyAbsSyn7
		 (Declar happy_var_1 (fst happy_var_2)
	)
happyReduction_8 _ _  = notHappyAtAll 

happyReduce_9 = happySpecReduce_1  8 happyReduction_9
happyReduction_9 _
	 =  HappyAbsSyn8
		 (Planet
	)

happyReduce_10 = happySpecReduce_1  8 happyReduction_10
happyReduction_10 _
	 =  HappyAbsSyn8
		 (Cloud
	)

happyReduce_11 = happySpecReduce_1  8 happyReduction_11
happyReduction_11 _
	 =  HappyAbsSyn8
		 (Star
	)

happyReduce_12 = happySpecReduce_1  8 happyReduction_12
happyReduction_12 _
	 =  HappyAbsSyn8
		 (Moon
	)

happyReduce_13 = happySpecReduce_1  8 happyReduction_13
happyReduction_13 (HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn8
		 (happy_var_1
	)
happyReduction_13 _  = notHappyAtAll 

happyReduce_14 = happyReduce 4 9 happyReduction_14
happyReduction_14 (_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn8  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn9
		 (Cluster happy_var_2
	) `HappyStk` happyRest

happyReduce_15 = happyReduce 4 9 happyReduction_15
happyReduction_15 (_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn8  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn9
		 (Quasar happy_var_2
	) `HappyStk` happyRest

happyReduce_16 = happyReduce 4 9 happyReduction_16
happyReduction_16 (_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn8  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn9
		 (Nebula happy_var_2
	) `HappyStk` happyRest

happyReduce_17 = happySpecReduce_2  9 happyReduction_17
happyReduction_17 (HappyAbsSyn8  happy_var_2)
	_
	 =  HappyAbsSyn9
		 (Pointer happy_var_2
	)
happyReduction_17 _ _  = notHappyAtAll 

happyReduce_18 = happySpecReduce_1  10 happyReduction_18
happyReduction_18 (HappyTerminal (TkId happy_var_1))
	 =  HappyAbsSyn10
		 (Var (fst happy_var_1)
	)
happyReduction_18 _  = notHappyAtAll 

happyReduce_19 = happySpecReduce_3  10 happyReduction_19
happyReduction_19 (HappyTerminal (TkId happy_var_3))
	_
	(HappyTerminal (TkId happy_var_1))
	 =  HappyAbsSyn10
		 (Attr (Var (fst happy_var_1)) (fst happy_var_3)
	)
happyReduction_19 _ _ _  = notHappyAtAll 

happyReduce_20 = happyReduce 4 10 happyReduction_20
happyReduction_20 ((HappyAbsSyn12  happy_var_4) `HappyStk`
	(HappyTerminal (TkId happy_var_3)) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TkId happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn10
		 (Access (Attr (Var (fst happy_var_1)) (fst happy_var_3)) happy_var_4
	) `HappyStk` happyRest

happyReduce_21 = happyReduce 4 10 happyReduction_21
happyReduction_21 ((HappyTerminal (TkId happy_var_4)) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn12  happy_var_2) `HappyStk`
	(HappyTerminal (TkId happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn10
		 (Attr (Access (Var (fst happy_var_1)) happy_var_2) (fst happy_var_4)
	) `HappyStk` happyRest

happyReduce_22 = happySpecReduce_2  10 happyReduction_22
happyReduction_22 (HappyAbsSyn12  happy_var_2)
	(HappyTerminal (TkId happy_var_1))
	 =  HappyAbsSyn10
		 (Access (Var (fst happy_var_1)) happy_var_2
	)
happyReduction_22 _ _  = notHappyAtAll 

happyReduce_23 = happySpecReduce_3  10 happyReduction_23
happyReduction_23 _
	(HappyAbsSyn10  happy_var_2)
	_
	 =  HappyAbsSyn10
		 (happy_var_2
	)
happyReduction_23 _ _ _  = notHappyAtAll 

happyReduce_24 = happySpecReduce_1  11 happyReduction_24
happyReduction_24 (HappyAbsSyn10  happy_var_1)
	 =  HappyAbsSyn11
		 (Lval happy_var_1
	)
happyReduction_24 _  = notHappyAtAll 

happyReduce_25 = happySpecReduce_1  11 happyReduction_25
happyReduction_25 (HappyAbsSyn13  happy_var_1)
	 =  HappyAbsSyn11
		 (Bool happy_var_1
	)
happyReduction_25 _  = notHappyAtAll 

happyReduce_26 = happySpecReduce_3  12 happyReduction_26
happyReduction_26 _
	(HappyTerminal (TkString happy_var_2))
	_
	 =  HappyAbsSyn12
		 (Dict (fst happy_var_2)
	)
happyReduction_26 _ _ _  = notHappyAtAll 

happyReduce_27 = happyReduce 4 12 happyReduction_27
happyReduction_27 ((HappyAbsSyn12  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TkString happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn12
		 (ManyAc (Dict (fst happy_var_2)) happy_var_4
	) `HappyStk` happyRest

happyReduce_28 = happySpecReduce_1  13 happyReduction_28
happyReduction_28 (HappyAbsSyn14  happy_var_1)
	 =  HappyAbsSyn13
		 (happy_var_1
	)
happyReduction_28 _  = notHappyAtAll 

happyReduce_29 = happySpecReduce_3  13 happyReduction_29
happyReduction_29 (HappyAbsSyn13  happy_var_3)
	_
	(HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn13
		 (And happy_var_1 happy_var_3
	)
happyReduction_29 _ _ _  = notHappyAtAll 

happyReduce_30 = happySpecReduce_3  13 happyReduction_30
happyReduction_30 (HappyAbsSyn13  happy_var_3)
	_
	(HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn13
		 (Bitand happy_var_1 happy_var_3
	)
happyReduction_30 _ _ _  = notHappyAtAll 

happyReduce_31 = happySpecReduce_3  13 happyReduction_31
happyReduction_31 (HappyAbsSyn13  happy_var_3)
	_
	(HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn13
		 (Or happy_var_1 happy_var_3
	)
happyReduction_31 _ _ _  = notHappyAtAll 

happyReduce_32 = happySpecReduce_3  13 happyReduction_32
happyReduction_32 (HappyAbsSyn13  happy_var_3)
	_
	(HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn13
		 (Bitor happy_var_1 happy_var_3
	)
happyReduction_32 _ _ _  = notHappyAtAll 

happyReduce_33 = happySpecReduce_2  13 happyReduction_33
happyReduction_33 (HappyAbsSyn13  happy_var_2)
	_
	 =  HappyAbsSyn13
		 (Not happy_var_2
	)
happyReduction_33 _ _  = notHappyAtAll 

happyReduce_34 = happySpecReduce_3  13 happyReduction_34
happyReduction_34 (HappyAbsSyn10  happy_var_3)
	_
	(HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn13
		 (And happy_var_1 (LBool happy_var_3)
	)
happyReduction_34 _ _ _  = notHappyAtAll 

happyReduce_35 = happySpecReduce_3  13 happyReduction_35
happyReduction_35 (HappyAbsSyn10  happy_var_3)
	_
	(HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn13
		 (Bitand happy_var_1 (LBool happy_var_3)
	)
happyReduction_35 _ _ _  = notHappyAtAll 

happyReduce_36 = happySpecReduce_3  13 happyReduction_36
happyReduction_36 (HappyAbsSyn10  happy_var_3)
	_
	(HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn13
		 (Or happy_var_1 (LBool happy_var_3)
	)
happyReduction_36 _ _ _  = notHappyAtAll 

happyReduce_37 = happySpecReduce_3  13 happyReduction_37
happyReduction_37 (HappyAbsSyn10  happy_var_3)
	_
	(HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn13
		 (Bitor happy_var_1 (LBool happy_var_3)
	)
happyReduction_37 _ _ _  = notHappyAtAll 

happyReduce_38 = happySpecReduce_2  13 happyReduction_38
happyReduction_38 (HappyAbsSyn10  happy_var_2)
	_
	 =  HappyAbsSyn13
		 (Not (LBool happy_var_2)
	)
happyReduction_38 _ _  = notHappyAtAll 

happyReduce_39 = happySpecReduce_3  13 happyReduction_39
happyReduction_39 _
	(HappyAbsSyn13  happy_var_2)
	_
	 =  HappyAbsSyn13
		 (happy_var_2
	)
happyReduction_39 _ _ _  = notHappyAtAll 

happyReduce_40 = happySpecReduce_1  14 happyReduction_40
happyReduction_40 _
	 =  HappyAbsSyn14
		 (New
	)

happyReduce_41 = happySpecReduce_1  14 happyReduction_41
happyReduction_41 _
	 =  HappyAbsSyn14
		 (Full
	)

happyReduce_42 = happySpecReduce_1  15 happyReduction_42
happyReduction_42 (HappyAbsSyn14  happy_var_1)
	 =  HappyAbsSyn15
		 (happy_var_1
	)
happyReduction_42 _  = notHappyAtAll 

happyReduce_43 = happySpecReduce_1  15 happyReduction_43
happyReduction_43 (HappyAbsSyn10  happy_var_1)
	 =  HappyAbsSyn15
		 (LBool happy_var_1
	)
happyReduction_43 _  = notHappyAtAll 

happyReduce_44 = happySpecReduce_3  15 happyReduction_44
happyReduction_44 _
	(HappyAbsSyn13  happy_var_2)
	_
	 =  HappyAbsSyn15
		 (happy_var_2
	)
happyReduction_44 _ _ _  = notHappyAtAll 

happyNewToken action sts stk [] =
	action 94 94 notHappyAtAll (HappyState action) sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = action i i tk (HappyState action) sts stk tks in
	case tk of {
	TkSpace     happy_dollar_dollar -> cont 16;
	TkEndofSpace happy_dollar_dollar -> cont 17;
	TkMoon      happy_dollar_dollar -> cont 18;
	TkNew       happy_dollar_dollar -> cont 19;
	TkFull      happy_dollar_dollar -> cont 20;
	TkPlanet    happy_dollar_dollar -> cont 21;
	TkCloud     happy_dollar_dollar -> cont 22;
	TkStar      happy_dollar_dollar -> cont 23;
	TkBlackhole happy_dollar_dollar -> cont 24;
	TkCosmos    happy_dollar_dollar -> cont 25;
	TkConstellation happy_dollar_dollar -> cont 26;
	TkCluster   happy_dollar_dollar -> cont 27;
	TkQuasar    happy_dollar_dollar -> cont 28;
	TkNebula    happy_dollar_dollar -> cont 29;
	TkGalaxy    happy_dollar_dollar -> cont 30;
	TkUFO       happy_dollar_dollar -> cont 31;
	TkComet     happy_dollar_dollar -> cont 32;
	TkSatellite happy_dollar_dollar -> cont 33;
	TkTerraform happy_dollar_dollar -> cont 34;
	TkPrint     happy_dollar_dollar -> cont 35;
	TkRead      happy_dollar_dollar -> cont 36;
	TkAround    happy_dollar_dollar -> cont 37;
	TkRange     happy_dollar_dollar -> cont 38;
	TkPop       happy_dollar_dollar -> cont 39;
	TkAdd       happy_dollar_dollar -> cont 40;
	TkBigbang   happy_dollar_dollar -> cont 41;
	TkIf        happy_dollar_dollar -> cont 42;
	TkElseif    happy_dollar_dollar -> cont 43;
	TkElse      happy_dollar_dollar -> cont 44;
	TkUnless    happy_dollar_dollar -> cont 45;
	TkWhile     happy_dollar_dollar -> cont 46;
	TkUntil     happy_dollar_dollar -> cont 47;
	TkOrbit     happy_dollar_dollar -> cont 48;
	TkArroba      happy_dollar_dollar -> cont 49;
	TkParA      happy_dollar_dollar -> cont 50;
	TkParC      happy_dollar_dollar -> cont 51;
	TkCorA      happy_dollar_dollar -> cont 52;
	TkCorC      happy_dollar_dollar -> cont 53;
	TkLlavA     happy_dollar_dollar -> cont 54;
	TkLlavC     happy_dollar_dollar -> cont 55;
	TkPuntopunto happy_dollar_dollar -> cont 56;
	TkPunto     happy_dollar_dollar -> cont 57;
	TkComa      happy_dollar_dollar -> cont 58;
	TkPuntoycoma happy_dollar_dollar -> cont 59;
	TkDospuntos happy_dollar_dollar -> cont 60;
	TkNyangara  happy_dollar_dollar -> cont 61;
	TkMasIgual  happy_dollar_dollar -> cont 62;
	TkMas       happy_dollar_dollar -> cont 63;
	TkMenosIgual happy_dollar_dollar -> cont 64;
	TkMenos     happy_dollar_dollar -> cont 65;
	TkMultIgual happy_dollar_dollar -> cont 66;
	TkMult     happy_dollar_dollar -> cont 67;
	TkPotenciaIgual happy_dollar_dollar -> cont 68;
	TkPotencia  happy_dollar_dollar -> cont 69;
	TkDivEnteraIgual happy_dollar_dollar -> cont 70;
	TkDivEntera happy_dollar_dollar -> cont 71;
	TkDivIgual  happy_dollar_dollar -> cont 72;
	TkDiv       happy_dollar_dollar -> cont 73;
	TkModIgual  happy_dollar_dollar -> cont 74;
	TkMod       happy_dollar_dollar -> cont 75;
	TkFlechita  happy_dollar_dollar -> cont 76;
	TkMayorIgual happy_dollar_dollar -> cont 77;
	TkMayor     happy_dollar_dollar -> cont 78;
	TkMenorIgual happy_dollar_dollar -> cont 79;
	TkMenor     happy_dollar_dollar -> cont 80;
	TkAnd       happy_dollar_dollar -> cont 81;
	TkBitand    happy_dollar_dollar -> cont 82;
	TkOr        happy_dollar_dollar -> cont 83;
	TkBitor     happy_dollar_dollar -> cont 84;
	TkIgual     happy_dollar_dollar -> cont 85;
	TkDistinto  happy_dollar_dollar -> cont 86;
	TkAsignacion happy_dollar_dollar -> cont 87;
	TkNegacion  happy_dollar_dollar -> cont 88;
	TkString happy_dollar_dollar -> cont 89;
	TkChar happy_dollar_dollar -> cont 90;
	TkId happy_dollar_dollar -> cont 91;
	TkFloat happy_dollar_dollar -> cont 92;
	TkInt happy_dollar_dollar -> cont 93;
	_ -> happyError' ((tk:tks), [])
	}

happyError_ explist 94 tk tks = happyError' (tks, explist)
happyError_ explist _ tk tks = happyError' ((tk:tks), explist)

newtype HappyIdentity a = HappyIdentity a
happyIdentity = HappyIdentity
happyRunIdentity (HappyIdentity a) = a

instance Functor HappyIdentity where
    fmap f (HappyIdentity a) = HappyIdentity (f a)

instance Applicative HappyIdentity where
    pure  = HappyIdentity
    (<*>) = ap
instance Monad HappyIdentity where
    return = pure
    (HappyIdentity p) >>= q = q p

happyThen :: () => HappyIdentity a -> (a -> HappyIdentity b) -> HappyIdentity b
happyThen = (>>=)
happyReturn :: () => a -> HappyIdentity a
happyReturn = (return)
happyThen1 m k tks = (>>=) m (\a -> k a tks)
happyReturn1 :: () => a -> b -> HappyIdentity a
happyReturn1 = \a tks -> (return) a
happyError' :: () => ([(Token)], [String]) -> HappyIdentity a
happyError' = HappyIdentity . (\(tokens, _) -> parseError tokens)
midnight tks = happyRunIdentity happySomeParser where
 happySomeParser = happyThen (happyParse action_0 tks) (\x -> case x of {HappyAbsSyn4 z -> happyReturn z; _other -> notHappyAtAll })

happySeq = happyDontSeq


parseError :: [Token] -> a
parseError _ = error "Parse error"

midny = midnight.alexScanTokens

data Program
      = Root Seq 
      deriving Show

data Seq
      = Empty
      | One Instr
      | Many Instr Seq
      deriving Show

data Instr 
      = Perro String
      | Declar Type String
      | Asig LValue RValue
      deriving Show

data Type
      = Planet
      | Cloud
      | Star
      | Moon
      | Cluster Type
      | Quasar Type
      | Nebula Type
      | Pointer Type
      deriving Show

data LValue
      = Var String
      | Access LValue Slice
      | Attr LValue String
      deriving Show

data RValue
      = Lval LValue
      | Bool ExpBool
      deriving Show

data Slice
      = ManyAc Slice Slice
      | Dict String
      deriving Show

data ExpBool
      = New
      | Full
      | And ExpBool ExpBool
      | Bitand ExpBool ExpBool
      | Or ExpBool ExpBool
      | Bitor ExpBool ExpBool
      | Not ExpBool
      | LBool LValue
      deriving Show


gato f = do
  s <- readFile(f)
  return( partition (not.isError) (alexScanTokens s) )


main = gato "test.mn"
{-# LINE 1 "templates\GenericTemplate.hs" #-}
{-# LINE 1 "templates\\\\GenericTemplate.hs" #-}
{-# LINE 1 "<built-in>" #-}
{-# LINE 1 "<command-line>" #-}
{-# LINE 8 "<command-line>" #-}
{-# LINE 1 "D:/GitHub/haskell-platform/build/ghc-bindist/local/lib/include/ghcversion.h" #-}















{-# LINE 8 "<command-line>" #-}
{-# LINE 1 "F:/Users/randy/AppData/Local/Temp/ghc1900_0/ghc_2.h" #-}


























































































































































































{-# LINE 8 "<command-line>" #-}
{-# LINE 1 "templates\\\\GenericTemplate.hs" #-}
-- Id: GenericTemplate.hs,v 1.26 2005/01/14 14:47:22 simonmar Exp 









{-# LINE 43 "templates\\\\GenericTemplate.hs" #-}

data Happy_IntList = HappyCons Int Happy_IntList







{-# LINE 65 "templates\\\\GenericTemplate.hs" #-}

{-# LINE 75 "templates\\\\GenericTemplate.hs" #-}

{-# LINE 84 "templates\\\\GenericTemplate.hs" #-}

infixr 9 `HappyStk`
data HappyStk a = HappyStk a (HappyStk a)

-----------------------------------------------------------------------------
-- starting the parse

happyParse start_state = happyNewToken start_state notHappyAtAll notHappyAtAll

-----------------------------------------------------------------------------
-- Accepting the parse

-- If the current token is (1), it means we've just accepted a partial
-- parse (a %partial parser).  We must ignore the saved token on the top of
-- the stack in this case.
happyAccept (1) tk st sts (_ `HappyStk` ans `HappyStk` _) =
        happyReturn1 ans
happyAccept j tk st sts (HappyStk ans _) = 
         (happyReturn1 ans)

-----------------------------------------------------------------------------
-- Arrays only: do the next action

{-# LINE 137 "templates\\\\GenericTemplate.hs" #-}

{-# LINE 147 "templates\\\\GenericTemplate.hs" #-}
indexShortOffAddr arr off = arr Happy_Data_Array.! off


{-# INLINE happyLt #-}
happyLt x y = (x < y)






readArrayBit arr bit =
    Bits.testBit (indexShortOffAddr arr (bit `div` 16)) (bit `mod` 16)






-----------------------------------------------------------------------------
-- HappyState data type (not arrays)



newtype HappyState b c = HappyState
        (Int ->                    -- token number
         Int ->                    -- token number (yes, again)
         b ->                           -- token semantic value
         HappyState b c ->              -- current state
         [HappyState b c] ->            -- state stack
         c)



-----------------------------------------------------------------------------
-- Shifting a token

happyShift new_state (1) tk st sts stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--     trace "shifting the error token" $
     new_state i i tk (HappyState (new_state)) ((st):(sts)) (stk)

happyShift new_state i tk st sts stk =
     happyNewToken new_state ((st):(sts)) ((HappyTerminal (tk))`HappyStk`stk)

-- happyReduce is specialised for the common cases.

happySpecReduce_0 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_0 nt fn j tk st@((HappyState (action))) sts stk
     = action nt j tk st ((st):(sts)) (fn `HappyStk` stk)

happySpecReduce_1 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_1 nt fn j tk _ sts@(((st@(HappyState (action))):(_))) (v1`HappyStk`stk')
     = let r = fn v1 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_2 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_2 nt fn j tk _ ((_):(sts@(((st@(HappyState (action))):(_))))) (v1`HappyStk`v2`HappyStk`stk')
     = let r = fn v1 v2 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_3 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_3 nt fn j tk _ ((_):(((_):(sts@(((st@(HappyState (action))):(_))))))) (v1`HappyStk`v2`HappyStk`v3`HappyStk`stk')
     = let r = fn v1 v2 v3 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happyReduce k i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyReduce k nt fn j tk st sts stk
     = case happyDrop (k - ((1) :: Int)) sts of
         sts1@(((st1@(HappyState (action))):(_))) ->
                let r = fn stk in  -- it doesn't hurt to always seq here...
                happyDoSeq r (action nt j tk st1 sts1 r)

happyMonadReduce k nt fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyMonadReduce k nt fn j tk st sts stk =
      case happyDrop k ((st):(sts)) of
        sts1@(((st1@(HappyState (action))):(_))) ->
          let drop_stk = happyDropStk k stk in
          happyThen1 (fn stk tk) (\r -> action nt j tk st1 sts1 (r `HappyStk` drop_stk))

happyMonad2Reduce k nt fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyMonad2Reduce k nt fn j tk st sts stk =
      case happyDrop k ((st):(sts)) of
        sts1@(((st1@(HappyState (action))):(_))) ->
         let drop_stk = happyDropStk k stk





             _ = nt :: Int
             new_state = action

          in
          happyThen1 (fn stk tk) (\r -> happyNewToken new_state sts1 (r `HappyStk` drop_stk))

happyDrop (0) l = l
happyDrop n ((_):(t)) = happyDrop (n - ((1) :: Int)) t

happyDropStk (0) l = l
happyDropStk n (x `HappyStk` xs) = happyDropStk (n - ((1)::Int)) xs

-----------------------------------------------------------------------------
-- Moving to a new state after a reduction

{-# LINE 267 "templates\\\\GenericTemplate.hs" #-}
happyGoto action j tk st = action j j tk (HappyState action)


-----------------------------------------------------------------------------
-- Error recovery ((1) is the error token)

-- parse error if we are in recovery and we fail again
happyFail explist (1) tk old_st _ stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--      trace "failing" $ 
        happyError_ explist i tk

{-  We don't need state discarding for our restricted implementation of
    "error".  In fact, it can cause some bogus parses, so I've disabled it
    for now --SDM

-- discard a state
happyFail  (1) tk old_st (((HappyState (action))):(sts)) 
                                                (saved_tok `HappyStk` _ `HappyStk` stk) =
--      trace ("discarding state, depth " ++ show (length stk))  $
        action (1) (1) tk (HappyState (action)) sts ((saved_tok`HappyStk`stk))
-}

-- Enter error recovery: generate an error token,
--                       save the old token and carry on.
happyFail explist i tk (HappyState (action)) sts stk =
--      trace "entering error recovery" $
        action (1) (1) tk (HappyState (action)) sts ( (HappyErrorToken (i)) `HappyStk` stk)

-- Internal happy errors:

notHappyAtAll :: a
notHappyAtAll = error "Internal Happy error\n"

-----------------------------------------------------------------------------
-- Hack to get the typechecker to accept our action functions







-----------------------------------------------------------------------------
-- Seq-ing.  If the --strict flag is given, then Happy emits 
--      happySeq = happyDoSeq
-- otherwise it emits
--      happySeq = happyDontSeq

happyDoSeq, happyDontSeq :: a -> b -> b
happyDoSeq   a b = a `seq` b
happyDontSeq a b = b

-----------------------------------------------------------------------------
-- Don't inline any functions from the template.  GHC has a nasty habit
-- of deciding to inline happyGoto everywhere, which increases the size of
-- the generated parser quite a bit.

{-# LINE 333 "templates\\\\GenericTemplate.hs" #-}
{-# NOINLINE happyShift #-}
{-# NOINLINE happySpecReduce_0 #-}
{-# NOINLINE happySpecReduce_1 #-}
{-# NOINLINE happySpecReduce_2 #-}
{-# NOINLINE happySpecReduce_3 #-}
{-# NOINLINE happyReduce #-}
{-# NOINLINE happyMonadReduce #-}
{-# NOINLINE happyGoto #-}
{-# NOINLINE happyFail #-}

-- end of Happy Template.
