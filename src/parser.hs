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

data HappyAbsSyn t4 t5 t6 t7 t8 t9 t10 t11 t12 t13 t14 t15 t16 t17
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
	| HappyAbsSyn16 t16
	| HappyAbsSyn17 t17

happyExpList :: Happy_Data_Array.Array Int Int
happyExpList = Happy_Data_Array.listArray (0,314) ([0,2,0,0,0,0,0,2,0,0,0,0,0,4,0,0,0,0,0,0,0,0,0,0,0,460,0,16424,0,4096,0,4,0,0,0,0,0,0,0,4096,0,0,0,0,0,0,0,0,0,0,0,0,0,4096,0,0,0,0,0,0,0,0,0,0,0,256,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,0,4096,0,456,0,16416,0,0,0,456,0,16416,0,0,0,0,0,1056,0,0,0,0,0,1024,0,0,0,0,0,520,4,29696,0,0,0,0,0,4096,0,0,0,0,0,0,0,0,0,64,0,0,0,0,0,16,0,0,0,48,0,8,4,29184,0,0,0,0,0,0,0,456,0,16424,0,4096,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,60,0,0,0,0,0,0,0,0,0,0,4437,0,0,0,0,0,0,0,0,0,0,0,0,0,0,48,0,8,4,29184,0,0,0,8,4,28672,0,48,0,8,0,4608,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,28672,0,0,0,0,0,0,0,32,0,0,0,0,0,0,0,0,0,0,0,576,0,0,0,0,0,8,4,28672,0,0,0,8,4,28672,0,0,0,64,0,0,0,0,0,0,0,4096,0,0,0,0,0,0,0,0,0,32,0,0,0,0,0,64,0,0,0,0,0,16,0,0,0,0,0,16,0,0,0,0,0,32,0,0,0,0,0,72,4,28672,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,48,0,8,0,4608,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16,0,0,0,0,0,16,0,0,0,0,0,8,4,28672,0,0,0,8,4,28672,0,0,0,8,4,28672,0,0,0,8,4,28672,0,0,0,8,4,28672,0,0,0,8,4,28672,0,48,0,8,0,4608,0,48,0,8,0,4608,0,48,0,8,0,4608,0,48,0,8,0,4608,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16,0,0,0,0,0,64,0,0,0,0,0,32,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,32,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,32,0,0,0,0,0,0,0,0,0
	])

{-# NOINLINE happyExpListPerState #-}
happyExpListPerState st =
    token_strs_expected
  where token_strs = ["error","%dummy","%start_midnight","S","Seq","Instr","Declar","Type","TComp","LValue","RValue","Slice","ExpBool","BoolLit","BoolAux","ExpNum","IntAux","space","end","moon","new","full","planet","cloud","star","blackhole","cosmos","constellation","cluster","quasar","nebula","galaxy","ufo","comet","satellite","terraform","print","read","around","range","pop","add","bigbang","if","elseif","else","unless","while","until","orbit","arroba","'('","')'","'['","']'","'{'","'}'","'..'","'.'","','","';'","':'","'~'","'+='","'+'","'-='","'-'","'*='","'*'","'^='","'^'","'//='","'//'","'/='","'/'","'%='","'%'","'->'","'>='","'>'","'<='","'<'","'&&'","'&'","'||'","'|'","'=='","'\9516\188='","'='","'\9516\188'","str","chr","id","float","int","%eof"]
        bit_start = st * 96
        bit_end = (st + 1) * 96
        read_bit = readArrayBit happyExpList
        bits = map read_bit [bit_start..bit_end - 1]
        bits_indexed = zip bits [0..95]
        token_strs_expected = concatMap f bits_indexed
        f (False, _) = []
        f (True, nr) = [token_strs !! nr]

action_0 (18) = happyShift action_4
action_0 (4) = happyGoto action_3
action_0 _ = happyFail (happyExpListPerState 0)

action_1 (18) = happyShift action_2
action_1 _ = happyFail (happyExpListPerState 1)

action_2 (19) = happyShift action_11
action_2 _ = happyFail (happyExpListPerState 2)

action_3 (96) = happyAccept
action_3 _ = happyFail (happyExpListPerState 3)

action_4 (19) = happyShift action_11
action_4 (20) = happyShift action_12
action_4 (23) = happyShift action_13
action_4 (24) = happyShift action_14
action_4 (25) = happyShift action_15
action_4 (52) = happyShift action_16
action_4 (54) = happyShift action_17
action_4 (63) = happyShift action_18
action_4 (93) = happyShift action_19
action_4 (5) = happyGoto action_5
action_4 (6) = happyGoto action_6
action_4 (7) = happyGoto action_7
action_4 (8) = happyGoto action_8
action_4 (9) = happyGoto action_9
action_4 (10) = happyGoto action_10
action_4 _ = happyFail (happyExpListPerState 4)

action_5 (19) = happyShift action_29
action_5 _ = happyFail (happyExpListPerState 5)

action_6 (61) = happyShift action_28
action_6 _ = happyReduce_3

action_7 _ = happyReduce_6

action_8 (93) = happyShift action_27
action_8 _ = happyFail (happyExpListPerState 8)

action_9 _ = happyReduce_13

action_10 (89) = happyShift action_26
action_10 _ = happyFail (happyExpListPerState 10)

action_11 _ = happyReduce_1

action_12 _ = happyReduce_12

action_13 _ = happyReduce_9

action_14 _ = happyReduce_10

action_15 _ = happyReduce_11

action_16 (52) = happyShift action_16
action_16 (93) = happyShift action_19
action_16 (10) = happyGoto action_25
action_16 _ = happyFail (happyExpListPerState 16)

action_17 (20) = happyShift action_12
action_17 (23) = happyShift action_13
action_17 (24) = happyShift action_14
action_17 (25) = happyShift action_15
action_17 (54) = happyShift action_17
action_17 (63) = happyShift action_18
action_17 (8) = happyGoto action_24
action_17 (9) = happyGoto action_9
action_17 _ = happyFail (happyExpListPerState 17)

action_18 (20) = happyShift action_12
action_18 (23) = happyShift action_13
action_18 (24) = happyShift action_14
action_18 (25) = happyShift action_15
action_18 (54) = happyShift action_17
action_18 (63) = happyShift action_18
action_18 (8) = happyGoto action_23
action_18 (9) = happyGoto action_9
action_18 _ = happyFail (happyExpListPerState 18)

action_19 (54) = happyShift action_21
action_19 (59) = happyShift action_22
action_19 (12) = happyGoto action_20
action_19 _ = happyReduce_18

action_20 (59) = happyShift action_53
action_20 _ = happyReduce_22

action_21 (52) = happyShift action_50
action_21 (58) = happyShift action_51
action_21 (67) = happyShift action_41
action_21 (91) = happyShift action_52
action_21 (93) = happyShift action_19
action_21 (94) = happyShift action_43
action_21 (95) = happyShift action_44
action_21 (10) = happyGoto action_48
action_21 (16) = happyGoto action_49
action_21 (17) = happyGoto action_37
action_21 _ = happyFail (happyExpListPerState 21)

action_22 (93) = happyShift action_47
action_22 _ = happyFail (happyExpListPerState 22)

action_23 _ = happyReduce_17

action_24 (55) = happyShift action_46
action_24 _ = happyFail (happyExpListPerState 24)

action_25 (53) = happyShift action_45
action_25 _ = happyFail (happyExpListPerState 25)

action_26 (21) = happyShift action_38
action_26 (22) = happyShift action_39
action_26 (52) = happyShift action_40
action_26 (67) = happyShift action_41
action_26 (90) = happyShift action_42
action_26 (93) = happyShift action_19
action_26 (94) = happyShift action_43
action_26 (95) = happyShift action_44
action_26 (10) = happyGoto action_31
action_26 (11) = happyGoto action_32
action_26 (13) = happyGoto action_33
action_26 (14) = happyGoto action_34
action_26 (15) = happyGoto action_35
action_26 (16) = happyGoto action_36
action_26 (17) = happyGoto action_37
action_26 _ = happyFail (happyExpListPerState 26)

action_27 _ = happyReduce_8

action_28 (20) = happyShift action_12
action_28 (23) = happyShift action_13
action_28 (24) = happyShift action_14
action_28 (25) = happyShift action_15
action_28 (52) = happyShift action_16
action_28 (54) = happyShift action_17
action_28 (63) = happyShift action_18
action_28 (93) = happyShift action_19
action_28 (5) = happyGoto action_30
action_28 (6) = happyGoto action_6
action_28 (7) = happyGoto action_7
action_28 (8) = happyGoto action_8
action_28 (9) = happyGoto action_9
action_28 (10) = happyGoto action_10
action_28 _ = happyReduce_4

action_29 _ = happyReduce_2

action_30 _ = happyReduce_5

action_31 (65) = happyReduce_72
action_31 (67) = happyReduce_72
action_31 (69) = happyReduce_72
action_31 (71) = happyReduce_72
action_31 (73) = happyReduce_72
action_31 (77) = happyReduce_72
action_31 (83) = happyReduce_52
action_31 (84) = happyReduce_52
action_31 (85) = happyReduce_52
action_31 (86) = happyReduce_52
action_31 _ = happyReduce_24

action_32 _ = happyReduce_7

action_33 _ = happyReduce_25

action_34 (83) = happyReduce_51
action_34 (84) = happyReduce_51
action_34 (85) = happyReduce_51
action_34 (86) = happyReduce_51
action_34 _ = happyReduce_37

action_35 (83) = happyShift action_78
action_35 (84) = happyShift action_79
action_35 (85) = happyShift action_80
action_35 (86) = happyShift action_81
action_35 _ = happyFail (happyExpListPerState 35)

action_36 _ = happyReduce_26

action_37 (65) = happyShift action_72
action_37 (67) = happyShift action_73
action_37 (69) = happyShift action_74
action_37 (71) = happyShift action_75
action_37 (73) = happyShift action_76
action_37 (77) = happyShift action_77
action_37 _ = happyFail (happyExpListPerState 37)

action_38 _ = happyReduce_49

action_39 _ = happyReduce_50

action_40 (21) = happyShift action_38
action_40 (22) = happyShift action_39
action_40 (52) = happyShift action_40
action_40 (67) = happyShift action_41
action_40 (90) = happyShift action_42
action_40 (93) = happyShift action_19
action_40 (94) = happyShift action_43
action_40 (95) = happyShift action_44
action_40 (10) = happyGoto action_70
action_40 (13) = happyGoto action_71
action_40 (14) = happyGoto action_34
action_40 (15) = happyGoto action_35
action_40 (16) = happyGoto action_58
action_40 (17) = happyGoto action_37
action_40 _ = happyFail (happyExpListPerState 40)

action_41 (52) = happyShift action_50
action_41 (67) = happyShift action_41
action_41 (93) = happyShift action_19
action_41 (94) = happyShift action_43
action_41 (95) = happyShift action_44
action_41 (10) = happyGoto action_68
action_41 (16) = happyGoto action_69
action_41 (17) = happyGoto action_37
action_41 _ = happyFail (happyExpListPerState 41)

action_42 (21) = happyShift action_38
action_42 (22) = happyShift action_39
action_42 (52) = happyShift action_67
action_42 (90) = happyShift action_42
action_42 (93) = happyShift action_19
action_42 (10) = happyGoto action_65
action_42 (13) = happyGoto action_66
action_42 (14) = happyGoto action_34
action_42 (15) = happyGoto action_35
action_42 _ = happyFail (happyExpListPerState 42)

action_43 _ = happyReduce_71

action_44 (65) = happyReduce_70
action_44 (67) = happyReduce_70
action_44 (69) = happyReduce_70
action_44 (71) = happyReduce_70
action_44 (73) = happyReduce_70
action_44 (77) = happyReduce_70
action_44 _ = happyReduce_54

action_45 _ = happyReduce_23

action_46 (29) = happyShift action_62
action_46 (30) = happyShift action_63
action_46 (31) = happyShift action_64
action_46 _ = happyFail (happyExpListPerState 46)

action_47 (54) = happyShift action_21
action_47 (12) = happyGoto action_61
action_47 _ = happyReduce_19

action_48 _ = happyReduce_72

action_49 (55) = happyShift action_59
action_49 (58) = happyShift action_60
action_49 _ = happyFail (happyExpListPerState 49)

action_50 (52) = happyShift action_50
action_50 (67) = happyShift action_41
action_50 (93) = happyShift action_19
action_50 (94) = happyShift action_43
action_50 (95) = happyShift action_44
action_50 (10) = happyGoto action_57
action_50 (16) = happyGoto action_58
action_50 (17) = happyGoto action_37
action_50 _ = happyFail (happyExpListPerState 50)

action_51 (52) = happyShift action_50
action_51 (67) = happyShift action_41
action_51 (93) = happyShift action_19
action_51 (94) = happyShift action_43
action_51 (95) = happyShift action_44
action_51 (10) = happyGoto action_48
action_51 (16) = happyGoto action_56
action_51 (17) = happyGoto action_37
action_51 _ = happyFail (happyExpListPerState 51)

action_52 (55) = happyShift action_55
action_52 _ = happyFail (happyExpListPerState 52)

action_53 (93) = happyShift action_54
action_53 _ = happyFail (happyExpListPerState 53)

action_54 _ = happyReduce_21

action_55 (54) = happyShift action_21
action_55 (12) = happyGoto action_109
action_55 _ = happyReduce_27

action_56 (55) = happyShift action_108
action_56 _ = happyFail (happyExpListPerState 56)

action_57 (53) = happyShift action_45
action_57 _ = happyReduce_72

action_58 (53) = happyShift action_107
action_58 _ = happyFail (happyExpListPerState 58)

action_59 (54) = happyShift action_21
action_59 (12) = happyGoto action_106
action_59 _ = happyReduce_29

action_60 (52) = happyShift action_50
action_60 (55) = happyShift action_105
action_60 (67) = happyShift action_41
action_60 (93) = happyShift action_19
action_60 (94) = happyShift action_43
action_60 (95) = happyShift action_44
action_60 (10) = happyGoto action_48
action_60 (16) = happyGoto action_104
action_60 (17) = happyGoto action_37
action_60 _ = happyFail (happyExpListPerState 60)

action_61 _ = happyReduce_20

action_62 _ = happyReduce_14

action_63 _ = happyReduce_15

action_64 _ = happyReduce_16

action_65 (83) = happyReduce_52
action_65 (84) = happyReduce_52
action_65 (85) = happyReduce_52
action_65 (86) = happyReduce_52
action_65 _ = happyReduce_47

action_66 _ = happyReduce_42

action_67 (21) = happyShift action_38
action_67 (22) = happyShift action_39
action_67 (52) = happyShift action_67
action_67 (90) = happyShift action_42
action_67 (93) = happyShift action_19
action_67 (10) = happyGoto action_103
action_67 (13) = happyGoto action_71
action_67 (14) = happyGoto action_34
action_67 (15) = happyGoto action_35
action_67 _ = happyFail (happyExpListPerState 67)

action_68 (65) = happyReduce_72
action_68 (67) = happyReduce_72
action_68 (69) = happyReduce_72
action_68 (71) = happyReduce_72
action_68 (73) = happyReduce_72
action_68 (77) = happyReduce_72
action_68 _ = happyReduce_68

action_69 _ = happyReduce_61

action_70 (53) = happyShift action_45
action_70 (83) = happyReduce_52
action_70 (84) = happyReduce_52
action_70 (85) = happyReduce_52
action_70 (86) = happyReduce_52
action_70 _ = happyReduce_72

action_71 (53) = happyShift action_102
action_71 _ = happyFail (happyExpListPerState 71)

action_72 (52) = happyShift action_50
action_72 (67) = happyShift action_41
action_72 (93) = happyShift action_19
action_72 (94) = happyShift action_43
action_72 (95) = happyShift action_44
action_72 (10) = happyGoto action_100
action_72 (16) = happyGoto action_101
action_72 (17) = happyGoto action_37
action_72 _ = happyFail (happyExpListPerState 72)

action_73 (52) = happyShift action_50
action_73 (67) = happyShift action_41
action_73 (93) = happyShift action_19
action_73 (94) = happyShift action_43
action_73 (95) = happyShift action_44
action_73 (10) = happyGoto action_98
action_73 (16) = happyGoto action_99
action_73 (17) = happyGoto action_37
action_73 _ = happyFail (happyExpListPerState 73)

action_74 (52) = happyShift action_50
action_74 (67) = happyShift action_41
action_74 (93) = happyShift action_19
action_74 (94) = happyShift action_43
action_74 (95) = happyShift action_44
action_74 (10) = happyGoto action_96
action_74 (16) = happyGoto action_97
action_74 (17) = happyGoto action_37
action_74 _ = happyFail (happyExpListPerState 74)

action_75 (52) = happyShift action_50
action_75 (67) = happyShift action_41
action_75 (93) = happyShift action_19
action_75 (94) = happyShift action_43
action_75 (95) = happyShift action_44
action_75 (10) = happyGoto action_94
action_75 (16) = happyGoto action_95
action_75 (17) = happyGoto action_37
action_75 _ = happyFail (happyExpListPerState 75)

action_76 (52) = happyShift action_50
action_76 (67) = happyShift action_41
action_76 (93) = happyShift action_19
action_76 (94) = happyShift action_43
action_76 (95) = happyShift action_44
action_76 (10) = happyGoto action_92
action_76 (16) = happyGoto action_93
action_76 (17) = happyGoto action_37
action_76 _ = happyFail (happyExpListPerState 76)

action_77 (52) = happyShift action_50
action_77 (67) = happyShift action_41
action_77 (93) = happyShift action_19
action_77 (94) = happyShift action_43
action_77 (95) = happyShift action_44
action_77 (10) = happyGoto action_90
action_77 (16) = happyGoto action_91
action_77 (17) = happyGoto action_37
action_77 _ = happyFail (happyExpListPerState 77)

action_78 (21) = happyShift action_38
action_78 (22) = happyShift action_39
action_78 (52) = happyShift action_67
action_78 (90) = happyShift action_42
action_78 (93) = happyShift action_19
action_78 (10) = happyGoto action_88
action_78 (13) = happyGoto action_89
action_78 (14) = happyGoto action_34
action_78 (15) = happyGoto action_35
action_78 _ = happyFail (happyExpListPerState 78)

action_79 (21) = happyShift action_38
action_79 (22) = happyShift action_39
action_79 (52) = happyShift action_67
action_79 (90) = happyShift action_42
action_79 (93) = happyShift action_19
action_79 (10) = happyGoto action_86
action_79 (13) = happyGoto action_87
action_79 (14) = happyGoto action_34
action_79 (15) = happyGoto action_35
action_79 _ = happyFail (happyExpListPerState 79)

action_80 (21) = happyShift action_38
action_80 (22) = happyShift action_39
action_80 (52) = happyShift action_67
action_80 (90) = happyShift action_42
action_80 (93) = happyShift action_19
action_80 (10) = happyGoto action_84
action_80 (13) = happyGoto action_85
action_80 (14) = happyGoto action_34
action_80 (15) = happyGoto action_35
action_80 _ = happyFail (happyExpListPerState 80)

action_81 (21) = happyShift action_38
action_81 (22) = happyShift action_39
action_81 (52) = happyShift action_67
action_81 (90) = happyShift action_42
action_81 (93) = happyShift action_19
action_81 (10) = happyGoto action_82
action_81 (13) = happyGoto action_83
action_81 (14) = happyGoto action_34
action_81 (15) = happyGoto action_35
action_81 _ = happyFail (happyExpListPerState 81)

action_82 (83) = happyReduce_52
action_82 (84) = happyReduce_52
action_82 (85) = happyReduce_52
action_82 (86) = happyReduce_52
action_82 _ = happyReduce_46

action_83 _ = happyReduce_41

action_84 (83) = happyReduce_52
action_84 (84) = happyReduce_52
action_84 (85) = happyReduce_52
action_84 (86) = happyReduce_52
action_84 _ = happyReduce_45

action_85 _ = happyReduce_40

action_86 (83) = happyReduce_52
action_86 (84) = happyReduce_52
action_86 (85) = happyReduce_52
action_86 (86) = happyReduce_52
action_86 _ = happyReduce_44

action_87 _ = happyReduce_39

action_88 (83) = happyReduce_52
action_88 (84) = happyReduce_52
action_88 (85) = happyReduce_52
action_88 (86) = happyReduce_52
action_88 _ = happyReduce_43

action_89 _ = happyReduce_38

action_90 (65) = happyReduce_72
action_90 (67) = happyReduce_72
action_90 (69) = happyReduce_72
action_90 (71) = happyReduce_72
action_90 (73) = happyReduce_72
action_90 (77) = happyReduce_72
action_90 _ = happyReduce_67

action_91 _ = happyReduce_60

action_92 (65) = happyReduce_72
action_92 (67) = happyReduce_72
action_92 (69) = happyReduce_72
action_92 (71) = happyReduce_72
action_92 (73) = happyReduce_72
action_92 (77) = happyReduce_72
action_92 _ = happyReduce_66

action_93 _ = happyReduce_59

action_94 (65) = happyReduce_72
action_94 (67) = happyReduce_72
action_94 (69) = happyReduce_72
action_94 (71) = happyReduce_72
action_94 (73) = happyReduce_72
action_94 (77) = happyReduce_72
action_94 _ = happyReduce_65

action_95 _ = happyReduce_58

action_96 (65) = happyReduce_72
action_96 (67) = happyReduce_72
action_96 (69) = happyReduce_72
action_96 (71) = happyReduce_72
action_96 (73) = happyReduce_72
action_96 (77) = happyReduce_72
action_96 _ = happyReduce_64

action_97 _ = happyReduce_57

action_98 (65) = happyReduce_72
action_98 (67) = happyReduce_72
action_98 (69) = happyReduce_72
action_98 (71) = happyReduce_72
action_98 (73) = happyReduce_72
action_98 (77) = happyReduce_72
action_98 _ = happyReduce_63

action_99 _ = happyReduce_56

action_100 (65) = happyReduce_72
action_100 (67) = happyReduce_72
action_100 (69) = happyReduce_72
action_100 (71) = happyReduce_72
action_100 (73) = happyReduce_72
action_100 (77) = happyReduce_72
action_100 _ = happyReduce_62

action_101 _ = happyReduce_55

action_102 (83) = happyReduce_53
action_102 (84) = happyReduce_53
action_102 (85) = happyReduce_53
action_102 (86) = happyReduce_53
action_102 _ = happyReduce_48

action_103 (53) = happyShift action_45
action_103 _ = happyReduce_52

action_104 (55) = happyShift action_112
action_104 _ = happyFail (happyExpListPerState 104)

action_105 (54) = happyShift action_21
action_105 (12) = happyGoto action_111
action_105 _ = happyReduce_35

action_106 _ = happyReduce_30

action_107 (65) = happyReduce_73
action_107 (67) = happyReduce_73
action_107 (69) = happyReduce_73
action_107 (71) = happyReduce_73
action_107 (73) = happyReduce_73
action_107 (77) = happyReduce_73
action_107 _ = happyReduce_69

action_108 (54) = happyShift action_21
action_108 (12) = happyGoto action_110
action_108 _ = happyReduce_33

action_109 _ = happyReduce_28

action_110 _ = happyReduce_34

action_111 _ = happyReduce_36

action_112 (54) = happyShift action_21
action_112 (12) = happyGoto action_113
action_112 _ = happyReduce_31

action_113 _ = happyReduce_32

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

happyReduce_26 = happySpecReduce_1  11 happyReduction_26
happyReduction_26 (HappyAbsSyn16  happy_var_1)
	 =  HappyAbsSyn11
		 (Int happy_var_1
	)
happyReduction_26 _  = notHappyAtAll 

happyReduce_27 = happySpecReduce_3  12 happyReduction_27
happyReduction_27 _
	(HappyTerminal (TkString happy_var_2))
	_
	 =  HappyAbsSyn12
		 (Key (fst happy_var_2)
	)
happyReduction_27 _ _ _  = notHappyAtAll 

happyReduce_28 = happyReduce 4 12 happyReduction_28
happyReduction_28 ((HappyAbsSyn12  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TkString happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn12
		 (ManyAc (Key (fst happy_var_2)) happy_var_4
	) `HappyStk` happyRest

happyReduce_29 = happySpecReduce_3  12 happyReduction_29
happyReduction_29 _
	(HappyAbsSyn16  happy_var_2)
	_
	 =  HappyAbsSyn12
		 (Index happy_var_2
	)
happyReduction_29 _ _ _  = notHappyAtAll 

happyReduce_30 = happyReduce 4 12 happyReduction_30
happyReduction_30 ((HappyAbsSyn12  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn16  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn12
		 (ManyAc (Index happy_var_2) happy_var_4
	) `HappyStk` happyRest

happyReduce_31 = happyReduce 5 12 happyReduction_31
happyReduction_31 (_ `HappyStk`
	(HappyAbsSyn16  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn16  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn12
		 (Interval happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_32 = happyReduce 6 12 happyReduction_32
happyReduction_32 ((HappyAbsSyn12  happy_var_6) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn16  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn16  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn12
		 (ManyAc (Interval happy_var_2 happy_var_4) happy_var_6
	) `HappyStk` happyRest

happyReduce_33 = happyReduce 4 12 happyReduction_33
happyReduction_33 (_ `HappyStk`
	(HappyAbsSyn16  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn12
		 (Interval (IntLit 0) happy_var_3
	) `HappyStk` happyRest

happyReduce_34 = happyReduce 5 12 happyReduction_34
happyReduction_34 ((HappyAbsSyn12  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn16  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn12
		 (ManyAc (Interval (IntLit 0) happy_var_3) happy_var_5
	) `HappyStk` happyRest

happyReduce_35 = happyReduce 4 12 happyReduction_35
happyReduction_35 (_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn16  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn12
		 (Begin happy_var_2
	) `HappyStk` happyRest

happyReduce_36 = happyReduce 5 12 happyReduction_36
happyReduction_36 ((HappyAbsSyn12  happy_var_5) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn16  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn12
		 (ManyAc (Begin happy_var_2) happy_var_5
	) `HappyStk` happyRest

happyReduce_37 = happySpecReduce_1  13 happyReduction_37
happyReduction_37 (HappyAbsSyn14  happy_var_1)
	 =  HappyAbsSyn13
		 (happy_var_1
	)
happyReduction_37 _  = notHappyAtAll 

happyReduce_38 = happySpecReduce_3  13 happyReduction_38
happyReduction_38 (HappyAbsSyn13  happy_var_3)
	_
	(HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn13
		 (And happy_var_1 happy_var_3
	)
happyReduction_38 _ _ _  = notHappyAtAll 

happyReduce_39 = happySpecReduce_3  13 happyReduction_39
happyReduction_39 (HappyAbsSyn13  happy_var_3)
	_
	(HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn13
		 (Bitand happy_var_1 happy_var_3
	)
happyReduction_39 _ _ _  = notHappyAtAll 

happyReduce_40 = happySpecReduce_3  13 happyReduction_40
happyReduction_40 (HappyAbsSyn13  happy_var_3)
	_
	(HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn13
		 (Or happy_var_1 happy_var_3
	)
happyReduction_40 _ _ _  = notHappyAtAll 

happyReduce_41 = happySpecReduce_3  13 happyReduction_41
happyReduction_41 (HappyAbsSyn13  happy_var_3)
	_
	(HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn13
		 (Bitor happy_var_1 happy_var_3
	)
happyReduction_41 _ _ _  = notHappyAtAll 

happyReduce_42 = happySpecReduce_2  13 happyReduction_42
happyReduction_42 (HappyAbsSyn13  happy_var_2)
	_
	 =  HappyAbsSyn13
		 (Not happy_var_2
	)
happyReduction_42 _ _  = notHappyAtAll 

happyReduce_43 = happySpecReduce_3  13 happyReduction_43
happyReduction_43 (HappyAbsSyn10  happy_var_3)
	_
	(HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn13
		 (And happy_var_1 (LBool happy_var_3)
	)
happyReduction_43 _ _ _  = notHappyAtAll 

happyReduce_44 = happySpecReduce_3  13 happyReduction_44
happyReduction_44 (HappyAbsSyn10  happy_var_3)
	_
	(HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn13
		 (Bitand happy_var_1 (LBool happy_var_3)
	)
happyReduction_44 _ _ _  = notHappyAtAll 

happyReduce_45 = happySpecReduce_3  13 happyReduction_45
happyReduction_45 (HappyAbsSyn10  happy_var_3)
	_
	(HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn13
		 (Or happy_var_1 (LBool happy_var_3)
	)
happyReduction_45 _ _ _  = notHappyAtAll 

happyReduce_46 = happySpecReduce_3  13 happyReduction_46
happyReduction_46 (HappyAbsSyn10  happy_var_3)
	_
	(HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn13
		 (Bitor happy_var_1 (LBool happy_var_3)
	)
happyReduction_46 _ _ _  = notHappyAtAll 

happyReduce_47 = happySpecReduce_2  13 happyReduction_47
happyReduction_47 (HappyAbsSyn10  happy_var_2)
	_
	 =  HappyAbsSyn13
		 (Not (LBool happy_var_2)
	)
happyReduction_47 _ _  = notHappyAtAll 

happyReduce_48 = happySpecReduce_3  13 happyReduction_48
happyReduction_48 _
	(HappyAbsSyn13  happy_var_2)
	_
	 =  HappyAbsSyn13
		 (happy_var_2
	)
happyReduction_48 _ _ _  = notHappyAtAll 

happyReduce_49 = happySpecReduce_1  14 happyReduction_49
happyReduction_49 _
	 =  HappyAbsSyn14
		 (New
	)

happyReduce_50 = happySpecReduce_1  14 happyReduction_50
happyReduction_50 _
	 =  HappyAbsSyn14
		 (Full
	)

happyReduce_51 = happySpecReduce_1  15 happyReduction_51
happyReduction_51 (HappyAbsSyn14  happy_var_1)
	 =  HappyAbsSyn15
		 (happy_var_1
	)
happyReduction_51 _  = notHappyAtAll 

happyReduce_52 = happySpecReduce_1  15 happyReduction_52
happyReduction_52 (HappyAbsSyn10  happy_var_1)
	 =  HappyAbsSyn15
		 (LBool happy_var_1
	)
happyReduction_52 _  = notHappyAtAll 

happyReduce_53 = happySpecReduce_3  15 happyReduction_53
happyReduction_53 _
	(HappyAbsSyn13  happy_var_2)
	_
	 =  HappyAbsSyn15
		 (happy_var_2
	)
happyReduction_53 _ _ _  = notHappyAtAll 

happyReduce_54 = happySpecReduce_1  16 happyReduction_54
happyReduction_54 (HappyTerminal (TkInt happy_var_1))
	 =  HappyAbsSyn16
		 (IntLit (fst happy_var_1)
	)
happyReduction_54 _  = notHappyAtAll 

happyReduce_55 = happySpecReduce_3  16 happyReduction_55
happyReduction_55 (HappyAbsSyn16  happy_var_3)
	_
	(HappyAbsSyn17  happy_var_1)
	 =  HappyAbsSyn16
		 (Sum happy_var_1 happy_var_3
	)
happyReduction_55 _ _ _  = notHappyAtAll 

happyReduce_56 = happySpecReduce_3  16 happyReduction_56
happyReduction_56 (HappyAbsSyn16  happy_var_3)
	_
	(HappyAbsSyn17  happy_var_1)
	 =  HappyAbsSyn16
		 (Sub happy_var_1 happy_var_3
	)
happyReduction_56 _ _ _  = notHappyAtAll 

happyReduce_57 = happySpecReduce_3  16 happyReduction_57
happyReduction_57 (HappyAbsSyn16  happy_var_3)
	_
	(HappyAbsSyn17  happy_var_1)
	 =  HappyAbsSyn16
		 (Mul happy_var_1 happy_var_3
	)
happyReduction_57 _ _ _  = notHappyAtAll 

happyReduce_58 = happySpecReduce_3  16 happyReduction_58
happyReduction_58 (HappyAbsSyn16  happy_var_3)
	_
	(HappyAbsSyn17  happy_var_1)
	 =  HappyAbsSyn16
		 (Pow happy_var_1 happy_var_3
	)
happyReduction_58 _ _ _  = notHappyAtAll 

happyReduce_59 = happySpecReduce_3  16 happyReduction_59
happyReduction_59 (HappyAbsSyn16  happy_var_3)
	_
	(HappyAbsSyn17  happy_var_1)
	 =  HappyAbsSyn16
		 (Div happy_var_1 happy_var_3
	)
happyReduction_59 _ _ _  = notHappyAtAll 

happyReduce_60 = happySpecReduce_3  16 happyReduction_60
happyReduction_60 (HappyAbsSyn16  happy_var_3)
	_
	(HappyAbsSyn17  happy_var_1)
	 =  HappyAbsSyn16
		 (Mod happy_var_1 happy_var_3
	)
happyReduction_60 _ _ _  = notHappyAtAll 

happyReduce_61 = happySpecReduce_2  16 happyReduction_61
happyReduction_61 (HappyAbsSyn16  happy_var_2)
	_
	 =  HappyAbsSyn16
		 (Neg happy_var_2
	)
happyReduction_61 _ _  = notHappyAtAll 

happyReduce_62 = happySpecReduce_3  16 happyReduction_62
happyReduction_62 (HappyAbsSyn10  happy_var_3)
	_
	(HappyAbsSyn17  happy_var_1)
	 =  HappyAbsSyn16
		 (Sum happy_var_1 (LNum happy_var_3)
	)
happyReduction_62 _ _ _  = notHappyAtAll 

happyReduce_63 = happySpecReduce_3  16 happyReduction_63
happyReduction_63 (HappyAbsSyn10  happy_var_3)
	_
	(HappyAbsSyn17  happy_var_1)
	 =  HappyAbsSyn16
		 (Sub happy_var_1 (LNum happy_var_3)
	)
happyReduction_63 _ _ _  = notHappyAtAll 

happyReduce_64 = happySpecReduce_3  16 happyReduction_64
happyReduction_64 (HappyAbsSyn10  happy_var_3)
	_
	(HappyAbsSyn17  happy_var_1)
	 =  HappyAbsSyn16
		 (Mul happy_var_1 (LNum happy_var_3)
	)
happyReduction_64 _ _ _  = notHappyAtAll 

happyReduce_65 = happySpecReduce_3  16 happyReduction_65
happyReduction_65 (HappyAbsSyn10  happy_var_3)
	_
	(HappyAbsSyn17  happy_var_1)
	 =  HappyAbsSyn16
		 (Pow happy_var_1 (LNum happy_var_3)
	)
happyReduction_65 _ _ _  = notHappyAtAll 

happyReduce_66 = happySpecReduce_3  16 happyReduction_66
happyReduction_66 (HappyAbsSyn10  happy_var_3)
	_
	(HappyAbsSyn17  happy_var_1)
	 =  HappyAbsSyn16
		 (Div happy_var_1 (LNum happy_var_3)
	)
happyReduction_66 _ _ _  = notHappyAtAll 

happyReduce_67 = happySpecReduce_3  16 happyReduction_67
happyReduction_67 (HappyAbsSyn10  happy_var_3)
	_
	(HappyAbsSyn17  happy_var_1)
	 =  HappyAbsSyn16
		 (Mod happy_var_1 (LNum happy_var_3)
	)
happyReduction_67 _ _ _  = notHappyAtAll 

happyReduce_68 = happySpecReduce_2  16 happyReduction_68
happyReduction_68 (HappyAbsSyn10  happy_var_2)
	_
	 =  HappyAbsSyn16
		 (Neg (LNum happy_var_2)
	)
happyReduction_68 _ _  = notHappyAtAll 

happyReduce_69 = happySpecReduce_3  16 happyReduction_69
happyReduction_69 _
	(HappyAbsSyn16  happy_var_2)
	_
	 =  HappyAbsSyn16
		 (happy_var_2
	)
happyReduction_69 _ _ _  = notHappyAtAll 

happyReduce_70 = happySpecReduce_1  17 happyReduction_70
happyReduction_70 (HappyTerminal (TkInt happy_var_1))
	 =  HappyAbsSyn17
		 (IntLit (fst happy_var_1)
	)
happyReduction_70 _  = notHappyAtAll 

happyReduce_71 = happySpecReduce_1  17 happyReduction_71
happyReduction_71 (HappyTerminal (TkFloat happy_var_1))
	 =  HappyAbsSyn17
		 (FloLit (fst happy_var_1)
	)
happyReduction_71 _  = notHappyAtAll 

happyReduce_72 = happySpecReduce_1  17 happyReduction_72
happyReduction_72 (HappyAbsSyn10  happy_var_1)
	 =  HappyAbsSyn17
		 (LNum happy_var_1
	)
happyReduction_72 _  = notHappyAtAll 

happyReduce_73 = happySpecReduce_3  17 happyReduction_73
happyReduction_73 _
	(HappyAbsSyn16  happy_var_2)
	_
	 =  HappyAbsSyn17
		 (happy_var_2
	)
happyReduction_73 _ _ _  = notHappyAtAll 

happyNewToken action sts stk [] =
	action 96 96 notHappyAtAll (HappyState action) sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = action i i tk (HappyState action) sts stk tks in
	case tk of {
	TkSpace     happy_dollar_dollar -> cont 18;
	TkEndofSpace happy_dollar_dollar -> cont 19;
	TkMoon      happy_dollar_dollar -> cont 20;
	TkNew       happy_dollar_dollar -> cont 21;
	TkFull      happy_dollar_dollar -> cont 22;
	TkPlanet    happy_dollar_dollar -> cont 23;
	TkCloud     happy_dollar_dollar -> cont 24;
	TkStar      happy_dollar_dollar -> cont 25;
	TkBlackhole happy_dollar_dollar -> cont 26;
	TkCosmos    happy_dollar_dollar -> cont 27;
	TkConstellation happy_dollar_dollar -> cont 28;
	TkCluster   happy_dollar_dollar -> cont 29;
	TkQuasar    happy_dollar_dollar -> cont 30;
	TkNebula    happy_dollar_dollar -> cont 31;
	TkGalaxy    happy_dollar_dollar -> cont 32;
	TkUFO       happy_dollar_dollar -> cont 33;
	TkComet     happy_dollar_dollar -> cont 34;
	TkSatellite happy_dollar_dollar -> cont 35;
	TkTerraform happy_dollar_dollar -> cont 36;
	TkPrint     happy_dollar_dollar -> cont 37;
	TkRead      happy_dollar_dollar -> cont 38;
	TkAround    happy_dollar_dollar -> cont 39;
	TkRange     happy_dollar_dollar -> cont 40;
	TkPop       happy_dollar_dollar -> cont 41;
	TkAdd       happy_dollar_dollar -> cont 42;
	TkBigbang   happy_dollar_dollar -> cont 43;
	TkIf        happy_dollar_dollar -> cont 44;
	TkElseif    happy_dollar_dollar -> cont 45;
	TkElse      happy_dollar_dollar -> cont 46;
	TkUnless    happy_dollar_dollar -> cont 47;
	TkWhile     happy_dollar_dollar -> cont 48;
	TkUntil     happy_dollar_dollar -> cont 49;
	TkOrbit     happy_dollar_dollar -> cont 50;
	TkArroba      happy_dollar_dollar -> cont 51;
	TkParA      happy_dollar_dollar -> cont 52;
	TkParC      happy_dollar_dollar -> cont 53;
	TkCorA      happy_dollar_dollar -> cont 54;
	TkCorC      happy_dollar_dollar -> cont 55;
	TkLlavA     happy_dollar_dollar -> cont 56;
	TkLlavC     happy_dollar_dollar -> cont 57;
	TkPuntopunto happy_dollar_dollar -> cont 58;
	TkPunto     happy_dollar_dollar -> cont 59;
	TkComa      happy_dollar_dollar -> cont 60;
	TkPuntoycoma happy_dollar_dollar -> cont 61;
	TkDospuntos happy_dollar_dollar -> cont 62;
	TkNyangara  happy_dollar_dollar -> cont 63;
	TkMasIgual  happy_dollar_dollar -> cont 64;
	TkMas       happy_dollar_dollar -> cont 65;
	TkMenosIgual happy_dollar_dollar -> cont 66;
	TkMenos     happy_dollar_dollar -> cont 67;
	TkMultIgual happy_dollar_dollar -> cont 68;
	TkMult     happy_dollar_dollar -> cont 69;
	TkPotenciaIgual happy_dollar_dollar -> cont 70;
	TkPotencia  happy_dollar_dollar -> cont 71;
	TkDivEnteraIgual happy_dollar_dollar -> cont 72;
	TkDivEntera happy_dollar_dollar -> cont 73;
	TkDivIgual  happy_dollar_dollar -> cont 74;
	TkDiv       happy_dollar_dollar -> cont 75;
	TkModIgual  happy_dollar_dollar -> cont 76;
	TkMod       happy_dollar_dollar -> cont 77;
	TkFlechita  happy_dollar_dollar -> cont 78;
	TkMayorIgual happy_dollar_dollar -> cont 79;
	TkMayor     happy_dollar_dollar -> cont 80;
	TkMenorIgual happy_dollar_dollar -> cont 81;
	TkMenor     happy_dollar_dollar -> cont 82;
	TkAnd       happy_dollar_dollar -> cont 83;
	TkBitand    happy_dollar_dollar -> cont 84;
	TkOr        happy_dollar_dollar -> cont 85;
	TkBitor     happy_dollar_dollar -> cont 86;
	TkIgual     happy_dollar_dollar -> cont 87;
	TkDistinto  happy_dollar_dollar -> cont 88;
	TkAsignacion happy_dollar_dollar -> cont 89;
	TkNegacion  happy_dollar_dollar -> cont 90;
	TkString happy_dollar_dollar -> cont 91;
	TkChar happy_dollar_dollar -> cont 92;
	TkId happy_dollar_dollar -> cont 93;
	TkFloat happy_dollar_dollar -> cont 94;
	TkInt happy_dollar_dollar -> cont 95;
	_ -> happyError' ((tk:tks), [])
	}

happyError_ explist 96 tk tks = happyError' (tks, explist)
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
      | Int ExpNum
      deriving Show

data Slice
      = ManyAc Slice Slice
      | Key String
      | Index ExpNum
      | Interval ExpNum ExpNum
      | Begin ExpNum
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

data ExpNum
      = IntLit Int
      | FloLit Float
      | LNum LValue
      | Sum ExpNum ExpNum
      | Sub ExpNum ExpNum
      | Mul ExpNum ExpNum
      | Pow ExpNum ExpNum
      | Div ExpNum ExpNum
      | Mod ExpNum ExpNum
      | Neg ExpNum
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
