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

data HappyAbsSyn t4 t5 t6 t7 t8 t9 t10 t11 t12 t13 t14 t15 t16 t17 t18 t19 t20
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
	| HappyAbsSyn18 t18
	| HappyAbsSyn19 t19
	| HappyAbsSyn20 t20

happyExpList :: Happy_Data_Array.Array Int Int
happyExpList = Happy_Data_Array.listArray (0,402) ([0,16,0,0,0,0,0,128,0,0,0,0,0,2048,0,0,0,0,0,0,0,0,0,0,0,0,230,0,8212,0,2048,0,16,0,0,0,0,0,0,0,0,2,0,0,0,0,0,0,0,0,0,0,0,0,0,128,0,0,0,0,0,0,0,0,0,0,0,512,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,64,0,32768,0,29184,0,2048,16,0,0,36864,3,16384,128,0,0,0,0,0,66,0,0,0,0,0,512,0,0,0,0,0,2080,16,53248,1,0,0,0,0,0,2,0,0,0,0,0,0,0,0,0,2,0,0,0,0,0,4,0,0,0,96,0,16,8,58368,0,0,0,0,0,0,0,58368,0,5120,32,0,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,240,0,0,0,0,0,0,0,0,0,0,21760,17,0,0,0,0,0,0,0,0,0,0,0,0,0,0,96,0,16,8,58368,0,0,0,128,64,0,7,6144,0,1024,0,0,9,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,32768,3,0,0,0,0,0,0,2048,0,0,0,0,0,0,0,0,0,0,0,0,36,0,0,0,0,0,4,2,14336,0,0,0,32,16,49152,1,0,0,2048,0,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,0,0,8,0,0,0,0,0,128,0,0,0,0,0,256,0,0,0,0,0,2048,0,0,0,0,0,32768,0,0,0,0,0,0,32777,0,3584,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,32768,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1536,0,256,0,16384,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4,0,0,0,0,0,32,0,0,0,0,0,128,64,0,7,0,0,1024,512,0,56,0,0,8192,4096,0,448,0,0,0,32769,0,3584,0,0,0,8,4,28672,0,0,0,64,32,32768,3,3072,0,512,0,32768,4,24576,0,4096,0,0,36,0,3,32768,0,0,288,0,24,0,4,0,2304,0,192,0,112,16,51200,1,0,0,0,1,0,0,0,0,4096,0,0,0,32768,1,16384,8192,0,912,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16,0,0,0,0,0,512,0,0,0,0,0,2048,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,512,0,0,0,0,0,0,0,0,0,768,0,192,64,8192,7,0,0,0,0,0,0,49152,0,12288,4096,0,456,0,0,0,0,0,0,0,0,0,0,0,0,0
	])

{-# NOINLINE happyExpListPerState #-}
happyExpListPerState st =
    token_strs_expected
  where token_strs = ["error","%dummy","%start_midnight","S","Seq","Instr","Declar","Type","TComp","LValue","RValue","Slice","Funcall","Args","Exp","ExpBool","BoolLit","BoolAux","ExpNum","IntAux","space","end","moon","new","full","planet","cloud","star","blackhole","cosmos","constellation","cluster","quasar","nebula","galaxy","ufo","comet","satellite","terraform","print","read","around","range","pop","add","bigbang","if","elseif","else","unless","while","until","orbit","'@'","'('","')'","'['","']'","'{'","'}'","'..'","'.'","','","';'","':'","'~'","'+='","'+'","'-='","'-'","'*='","'*'","'^='","'^'","'//='","'//'","'/='","'/'","'%='","'%'","'->'","'>='","'>'","'<='","'<'","'&&'","'&'","'||'","'|'","'=='","'\9516\188='","'='","'\9516\188'","str","chr","id","float","int","%eof"]
        bit_start = st * 99
        bit_end = (st + 1) * 99
        read_bit = readArrayBit happyExpList
        bits = map read_bit [bit_start..bit_end - 1]
        bits_indexed = zip bits [0..98]
        token_strs_expected = concatMap f bits_indexed
        f (False, _) = []
        f (True, nr) = [token_strs !! nr]

action_0 (21) = happyShift action_4
action_0 (4) = happyGoto action_3
action_0 _ = happyFail (happyExpListPerState 0)

action_1 (21) = happyShift action_2
action_1 _ = happyFail (happyExpListPerState 1)

action_2 (22) = happyShift action_11
action_2 _ = happyFail (happyExpListPerState 2)

action_3 (99) = happyAccept
action_3 _ = happyFail (happyExpListPerState 3)

action_4 (22) = happyShift action_11
action_4 (23) = happyShift action_12
action_4 (26) = happyShift action_13
action_4 (27) = happyShift action_14
action_4 (28) = happyShift action_15
action_4 (55) = happyShift action_16
action_4 (57) = happyShift action_17
action_4 (66) = happyShift action_18
action_4 (96) = happyShift action_19
action_4 (5) = happyGoto action_5
action_4 (6) = happyGoto action_6
action_4 (7) = happyGoto action_7
action_4 (8) = happyGoto action_8
action_4 (9) = happyGoto action_9
action_4 (10) = happyGoto action_10
action_4 _ = happyFail (happyExpListPerState 4)

action_5 (22) = happyShift action_29
action_5 _ = happyFail (happyExpListPerState 5)

action_6 (64) = happyShift action_28
action_6 _ = happyReduce_3

action_7 _ = happyReduce_6

action_8 (96) = happyShift action_27
action_8 _ = happyFail (happyExpListPerState 8)

action_9 _ = happyReduce_13

action_10 (92) = happyShift action_26
action_10 _ = happyFail (happyExpListPerState 10)

action_11 _ = happyReduce_1

action_12 _ = happyReduce_12

action_13 _ = happyReduce_9

action_14 _ = happyReduce_10

action_15 _ = happyReduce_11

action_16 (55) = happyShift action_16
action_16 (96) = happyShift action_19
action_16 (10) = happyGoto action_25
action_16 _ = happyFail (happyExpListPerState 16)

action_17 (23) = happyShift action_12
action_17 (26) = happyShift action_13
action_17 (27) = happyShift action_14
action_17 (28) = happyShift action_15
action_17 (57) = happyShift action_17
action_17 (66) = happyShift action_18
action_17 (8) = happyGoto action_24
action_17 (9) = happyGoto action_9
action_17 _ = happyFail (happyExpListPerState 17)

action_18 (23) = happyShift action_12
action_18 (26) = happyShift action_13
action_18 (27) = happyShift action_14
action_18 (28) = happyShift action_15
action_18 (57) = happyShift action_17
action_18 (66) = happyShift action_18
action_18 (8) = happyGoto action_23
action_18 (9) = happyGoto action_9
action_18 _ = happyFail (happyExpListPerState 18)

action_19 (57) = happyShift action_21
action_19 (62) = happyShift action_22
action_19 (12) = happyGoto action_20
action_19 _ = happyReduce_18

action_20 (62) = happyShift action_55
action_20 _ = happyReduce_22

action_21 (55) = happyShift action_52
action_21 (61) = happyShift action_53
action_21 (70) = happyShift action_43
action_21 (94) = happyShift action_54
action_21 (96) = happyShift action_19
action_21 (97) = happyShift action_45
action_21 (98) = happyShift action_46
action_21 (10) = happyGoto action_50
action_21 (19) = happyGoto action_51
action_21 (20) = happyGoto action_39
action_21 _ = happyFail (happyExpListPerState 21)

action_22 (96) = happyShift action_49
action_22 _ = happyFail (happyExpListPerState 22)

action_23 _ = happyReduce_17

action_24 (58) = happyShift action_48
action_24 _ = happyFail (happyExpListPerState 24)

action_25 (56) = happyShift action_47
action_25 _ = happyFail (happyExpListPerState 25)

action_26 (24) = happyShift action_40
action_26 (25) = happyShift action_41
action_26 (55) = happyShift action_42
action_26 (70) = happyShift action_43
action_26 (93) = happyShift action_44
action_26 (96) = happyShift action_19
action_26 (97) = happyShift action_45
action_26 (98) = happyShift action_46
action_26 (10) = happyGoto action_31
action_26 (11) = happyGoto action_32
action_26 (13) = happyGoto action_33
action_26 (15) = happyGoto action_34
action_26 (16) = happyGoto action_35
action_26 (17) = happyGoto action_36
action_26 (18) = happyGoto action_37
action_26 (19) = happyGoto action_38
action_26 (20) = happyGoto action_39
action_26 _ = happyFail (happyExpListPerState 26)

action_27 _ = happyReduce_8

action_28 (23) = happyShift action_12
action_28 (26) = happyShift action_13
action_28 (27) = happyShift action_14
action_28 (28) = happyShift action_15
action_28 (55) = happyShift action_16
action_28 (57) = happyShift action_17
action_28 (66) = happyShift action_18
action_28 (96) = happyShift action_19
action_28 (5) = happyGoto action_30
action_28 (6) = happyGoto action_6
action_28 (7) = happyGoto action_7
action_28 (8) = happyGoto action_8
action_28 (9) = happyGoto action_9
action_28 (10) = happyGoto action_10
action_28 _ = happyReduce_4

action_29 _ = happyReduce_2

action_30 _ = happyReduce_5

action_31 (55) = happyShift action_85
action_31 (68) = happyReduce_81
action_31 (70) = happyReduce_81
action_31 (72) = happyReduce_81
action_31 (74) = happyReduce_81
action_31 (76) = happyReduce_81
action_31 (80) = happyReduce_81
action_31 (86) = happyReduce_60
action_31 (87) = happyReduce_60
action_31 (88) = happyReduce_60
action_31 (89) = happyReduce_60
action_31 _ = happyReduce_44

action_32 _ = happyReduce_7

action_33 _ = happyReduce_43

action_34 _ = happyReduce_24

action_35 _ = happyReduce_25

action_36 (86) = happyReduce_59
action_36 (87) = happyReduce_59
action_36 (88) = happyReduce_59
action_36 (89) = happyReduce_59
action_36 _ = happyReduce_45

action_37 (86) = happyShift action_81
action_37 (87) = happyShift action_82
action_37 (88) = happyShift action_83
action_37 (89) = happyShift action_84
action_37 _ = happyFail (happyExpListPerState 37)

action_38 _ = happyReduce_26

action_39 (68) = happyShift action_75
action_39 (70) = happyShift action_76
action_39 (72) = happyShift action_77
action_39 (74) = happyShift action_78
action_39 (76) = happyShift action_79
action_39 (80) = happyShift action_80
action_39 _ = happyFail (happyExpListPerState 39)

action_40 _ = happyReduce_57

action_41 _ = happyReduce_58

action_42 (24) = happyShift action_40
action_42 (25) = happyShift action_41
action_42 (55) = happyShift action_42
action_42 (70) = happyShift action_43
action_42 (93) = happyShift action_44
action_42 (96) = happyShift action_19
action_42 (97) = happyShift action_45
action_42 (98) = happyShift action_46
action_42 (10) = happyGoto action_73
action_42 (16) = happyGoto action_74
action_42 (17) = happyGoto action_36
action_42 (18) = happyGoto action_37
action_42 (19) = happyGoto action_60
action_42 (20) = happyGoto action_39
action_42 _ = happyFail (happyExpListPerState 42)

action_43 (55) = happyShift action_52
action_43 (70) = happyShift action_43
action_43 (96) = happyShift action_19
action_43 (97) = happyShift action_45
action_43 (98) = happyShift action_46
action_43 (10) = happyGoto action_71
action_43 (19) = happyGoto action_72
action_43 (20) = happyGoto action_39
action_43 _ = happyFail (happyExpListPerState 43)

action_44 (24) = happyShift action_40
action_44 (25) = happyShift action_41
action_44 (55) = happyShift action_70
action_44 (93) = happyShift action_44
action_44 (96) = happyShift action_19
action_44 (10) = happyGoto action_67
action_44 (13) = happyGoto action_33
action_44 (15) = happyGoto action_68
action_44 (16) = happyGoto action_69
action_44 (17) = happyGoto action_36
action_44 (18) = happyGoto action_37
action_44 _ = happyFail (happyExpListPerState 44)

action_45 (68) = happyReduce_80
action_45 (70) = happyReduce_80
action_45 (72) = happyReduce_80
action_45 (74) = happyReduce_80
action_45 (76) = happyReduce_80
action_45 (80) = happyReduce_80
action_45 _ = happyReduce_63

action_46 (68) = happyReduce_79
action_46 (70) = happyReduce_79
action_46 (72) = happyReduce_79
action_46 (74) = happyReduce_79
action_46 (76) = happyReduce_79
action_46 (80) = happyReduce_79
action_46 _ = happyReduce_62

action_47 _ = happyReduce_23

action_48 (32) = happyShift action_64
action_48 (33) = happyShift action_65
action_48 (34) = happyShift action_66
action_48 _ = happyFail (happyExpListPerState 48)

action_49 (57) = happyShift action_21
action_49 (12) = happyGoto action_63
action_49 _ = happyReduce_19

action_50 _ = happyReduce_81

action_51 (58) = happyShift action_61
action_51 (61) = happyShift action_62
action_51 _ = happyFail (happyExpListPerState 51)

action_52 (55) = happyShift action_52
action_52 (70) = happyShift action_43
action_52 (96) = happyShift action_19
action_52 (97) = happyShift action_45
action_52 (98) = happyShift action_46
action_52 (10) = happyGoto action_59
action_52 (19) = happyGoto action_60
action_52 (20) = happyGoto action_39
action_52 _ = happyFail (happyExpListPerState 52)

action_53 (55) = happyShift action_52
action_53 (70) = happyShift action_43
action_53 (96) = happyShift action_19
action_53 (97) = happyShift action_45
action_53 (98) = happyShift action_46
action_53 (10) = happyGoto action_50
action_53 (19) = happyGoto action_58
action_53 (20) = happyGoto action_39
action_53 _ = happyFail (happyExpListPerState 53)

action_54 (58) = happyShift action_57
action_54 _ = happyFail (happyExpListPerState 54)

action_55 (96) = happyShift action_56
action_55 _ = happyFail (happyExpListPerState 55)

action_56 _ = happyReduce_21

action_57 (57) = happyShift action_21
action_57 (12) = happyGoto action_117
action_57 _ = happyReduce_27

action_58 (58) = happyShift action_116
action_58 _ = happyFail (happyExpListPerState 58)

action_59 (56) = happyShift action_47
action_59 _ = happyReduce_81

action_60 (56) = happyShift action_115
action_60 _ = happyFail (happyExpListPerState 60)

action_61 (57) = happyShift action_21
action_61 (12) = happyGoto action_114
action_61 _ = happyReduce_29

action_62 (55) = happyShift action_52
action_62 (58) = happyShift action_113
action_62 (70) = happyShift action_43
action_62 (96) = happyShift action_19
action_62 (97) = happyShift action_45
action_62 (98) = happyShift action_46
action_62 (10) = happyGoto action_50
action_62 (19) = happyGoto action_112
action_62 (20) = happyGoto action_39
action_62 _ = happyFail (happyExpListPerState 62)

action_63 _ = happyReduce_20

action_64 _ = happyReduce_14

action_65 _ = happyReduce_15

action_66 _ = happyReduce_16

action_67 (55) = happyShift action_85
action_67 (86) = happyReduce_60
action_67 (87) = happyReduce_60
action_67 (88) = happyReduce_60
action_67 (89) = happyReduce_60
action_67 _ = happyReduce_44

action_68 _ = happyReduce_55

action_69 _ = happyReduce_50

action_70 (24) = happyShift action_40
action_70 (25) = happyShift action_41
action_70 (55) = happyShift action_70
action_70 (93) = happyShift action_44
action_70 (96) = happyShift action_19
action_70 (10) = happyGoto action_111
action_70 (16) = happyGoto action_74
action_70 (17) = happyGoto action_36
action_70 (18) = happyGoto action_37
action_70 _ = happyFail (happyExpListPerState 70)

action_71 (68) = happyReduce_81
action_71 (70) = happyReduce_81
action_71 (72) = happyReduce_81
action_71 (74) = happyReduce_81
action_71 (76) = happyReduce_81
action_71 (80) = happyReduce_81
action_71 _ = happyReduce_77

action_72 _ = happyReduce_70

action_73 (56) = happyShift action_47
action_73 (86) = happyReduce_60
action_73 (87) = happyReduce_60
action_73 (88) = happyReduce_60
action_73 (89) = happyReduce_60
action_73 _ = happyReduce_81

action_74 (56) = happyShift action_110
action_74 _ = happyFail (happyExpListPerState 74)

action_75 (55) = happyShift action_52
action_75 (70) = happyShift action_43
action_75 (96) = happyShift action_19
action_75 (97) = happyShift action_45
action_75 (98) = happyShift action_46
action_75 (10) = happyGoto action_108
action_75 (19) = happyGoto action_109
action_75 (20) = happyGoto action_39
action_75 _ = happyFail (happyExpListPerState 75)

action_76 (55) = happyShift action_52
action_76 (70) = happyShift action_43
action_76 (96) = happyShift action_19
action_76 (97) = happyShift action_45
action_76 (98) = happyShift action_46
action_76 (10) = happyGoto action_106
action_76 (19) = happyGoto action_107
action_76 (20) = happyGoto action_39
action_76 _ = happyFail (happyExpListPerState 76)

action_77 (55) = happyShift action_52
action_77 (70) = happyShift action_43
action_77 (96) = happyShift action_19
action_77 (97) = happyShift action_45
action_77 (98) = happyShift action_46
action_77 (10) = happyGoto action_104
action_77 (19) = happyGoto action_105
action_77 (20) = happyGoto action_39
action_77 _ = happyFail (happyExpListPerState 77)

action_78 (55) = happyShift action_52
action_78 (70) = happyShift action_43
action_78 (96) = happyShift action_19
action_78 (97) = happyShift action_45
action_78 (98) = happyShift action_46
action_78 (10) = happyGoto action_102
action_78 (19) = happyGoto action_103
action_78 (20) = happyGoto action_39
action_78 _ = happyFail (happyExpListPerState 78)

action_79 (55) = happyShift action_52
action_79 (70) = happyShift action_43
action_79 (96) = happyShift action_19
action_79 (97) = happyShift action_45
action_79 (98) = happyShift action_46
action_79 (10) = happyGoto action_100
action_79 (19) = happyGoto action_101
action_79 (20) = happyGoto action_39
action_79 _ = happyFail (happyExpListPerState 79)

action_80 (55) = happyShift action_52
action_80 (70) = happyShift action_43
action_80 (96) = happyShift action_19
action_80 (97) = happyShift action_45
action_80 (98) = happyShift action_46
action_80 (10) = happyGoto action_98
action_80 (19) = happyGoto action_99
action_80 (20) = happyGoto action_39
action_80 _ = happyFail (happyExpListPerState 80)

action_81 (24) = happyShift action_40
action_81 (25) = happyShift action_41
action_81 (55) = happyShift action_70
action_81 (93) = happyShift action_44
action_81 (96) = happyShift action_19
action_81 (10) = happyGoto action_67
action_81 (13) = happyGoto action_33
action_81 (15) = happyGoto action_96
action_81 (16) = happyGoto action_97
action_81 (17) = happyGoto action_36
action_81 (18) = happyGoto action_37
action_81 _ = happyFail (happyExpListPerState 81)

action_82 (24) = happyShift action_40
action_82 (25) = happyShift action_41
action_82 (55) = happyShift action_70
action_82 (93) = happyShift action_44
action_82 (96) = happyShift action_19
action_82 (10) = happyGoto action_67
action_82 (13) = happyGoto action_33
action_82 (15) = happyGoto action_94
action_82 (16) = happyGoto action_95
action_82 (17) = happyGoto action_36
action_82 (18) = happyGoto action_37
action_82 _ = happyFail (happyExpListPerState 82)

action_83 (24) = happyShift action_40
action_83 (25) = happyShift action_41
action_83 (55) = happyShift action_70
action_83 (93) = happyShift action_44
action_83 (96) = happyShift action_19
action_83 (10) = happyGoto action_67
action_83 (13) = happyGoto action_33
action_83 (15) = happyGoto action_92
action_83 (16) = happyGoto action_93
action_83 (17) = happyGoto action_36
action_83 (18) = happyGoto action_37
action_83 _ = happyFail (happyExpListPerState 83)

action_84 (24) = happyShift action_40
action_84 (25) = happyShift action_41
action_84 (55) = happyShift action_70
action_84 (93) = happyShift action_44
action_84 (96) = happyShift action_19
action_84 (10) = happyGoto action_67
action_84 (13) = happyGoto action_33
action_84 (15) = happyGoto action_90
action_84 (16) = happyGoto action_91
action_84 (17) = happyGoto action_36
action_84 (18) = happyGoto action_37
action_84 _ = happyFail (happyExpListPerState 84)

action_85 (24) = happyShift action_40
action_85 (25) = happyShift action_41
action_85 (54) = happyShift action_88
action_85 (55) = happyShift action_42
action_85 (56) = happyShift action_89
action_85 (70) = happyShift action_43
action_85 (93) = happyShift action_44
action_85 (96) = happyShift action_19
action_85 (97) = happyShift action_45
action_85 (98) = happyShift action_46
action_85 (10) = happyGoto action_31
action_85 (11) = happyGoto action_86
action_85 (13) = happyGoto action_33
action_85 (14) = happyGoto action_87
action_85 (15) = happyGoto action_34
action_85 (16) = happyGoto action_35
action_85 (17) = happyGoto action_36
action_85 (18) = happyGoto action_37
action_85 (19) = happyGoto action_38
action_85 (20) = happyGoto action_39
action_85 _ = happyFail (happyExpListPerState 85)

action_86 (63) = happyShift action_123
action_86 _ = happyReduce_40

action_87 (56) = happyShift action_122
action_87 _ = happyFail (happyExpListPerState 87)

action_88 (24) = happyShift action_40
action_88 (25) = happyShift action_41
action_88 (55) = happyShift action_42
action_88 (70) = happyShift action_43
action_88 (93) = happyShift action_44
action_88 (96) = happyShift action_19
action_88 (97) = happyShift action_45
action_88 (98) = happyShift action_46
action_88 (10) = happyGoto action_31
action_88 (11) = happyGoto action_121
action_88 (13) = happyGoto action_33
action_88 (15) = happyGoto action_34
action_88 (16) = happyGoto action_35
action_88 (17) = happyGoto action_36
action_88 (18) = happyGoto action_37
action_88 (19) = happyGoto action_38
action_88 (20) = happyGoto action_39
action_88 _ = happyFail (happyExpListPerState 88)

action_89 _ = happyReduce_38

action_90 _ = happyReduce_54

action_91 _ = happyReduce_49

action_92 _ = happyReduce_53

action_93 _ = happyReduce_48

action_94 _ = happyReduce_52

action_95 _ = happyReduce_47

action_96 _ = happyReduce_51

action_97 _ = happyReduce_46

action_98 (68) = happyReduce_81
action_98 (70) = happyReduce_81
action_98 (72) = happyReduce_81
action_98 (74) = happyReduce_81
action_98 (76) = happyReduce_81
action_98 (80) = happyReduce_81
action_98 _ = happyReduce_76

action_99 _ = happyReduce_69

action_100 (68) = happyReduce_81
action_100 (70) = happyReduce_81
action_100 (72) = happyReduce_81
action_100 (74) = happyReduce_81
action_100 (76) = happyReduce_81
action_100 (80) = happyReduce_81
action_100 _ = happyReduce_75

action_101 _ = happyReduce_68

action_102 (68) = happyReduce_81
action_102 (70) = happyReduce_81
action_102 (72) = happyReduce_81
action_102 (74) = happyReduce_81
action_102 (76) = happyReduce_81
action_102 (80) = happyReduce_81
action_102 _ = happyReduce_74

action_103 _ = happyReduce_67

action_104 (68) = happyReduce_81
action_104 (70) = happyReduce_81
action_104 (72) = happyReduce_81
action_104 (74) = happyReduce_81
action_104 (76) = happyReduce_81
action_104 (80) = happyReduce_81
action_104 _ = happyReduce_73

action_105 _ = happyReduce_66

action_106 (68) = happyReduce_81
action_106 (70) = happyReduce_81
action_106 (72) = happyReduce_81
action_106 (74) = happyReduce_81
action_106 (76) = happyReduce_81
action_106 (80) = happyReduce_81
action_106 _ = happyReduce_72

action_107 _ = happyReduce_65

action_108 (68) = happyReduce_81
action_108 (70) = happyReduce_81
action_108 (72) = happyReduce_81
action_108 (74) = happyReduce_81
action_108 (76) = happyReduce_81
action_108 (80) = happyReduce_81
action_108 _ = happyReduce_71

action_109 _ = happyReduce_64

action_110 (86) = happyReduce_61
action_110 (87) = happyReduce_61
action_110 (88) = happyReduce_61
action_110 (89) = happyReduce_61
action_110 _ = happyReduce_56

action_111 (56) = happyShift action_47
action_111 _ = happyReduce_60

action_112 (58) = happyShift action_120
action_112 _ = happyFail (happyExpListPerState 112)

action_113 (57) = happyShift action_21
action_113 (12) = happyGoto action_119
action_113 _ = happyReduce_35

action_114 _ = happyReduce_30

action_115 (68) = happyReduce_82
action_115 (70) = happyReduce_82
action_115 (72) = happyReduce_82
action_115 (74) = happyReduce_82
action_115 (76) = happyReduce_82
action_115 (80) = happyReduce_82
action_115 _ = happyReduce_78

action_116 (57) = happyShift action_21
action_116 (12) = happyGoto action_118
action_116 _ = happyReduce_33

action_117 _ = happyReduce_28

action_118 _ = happyReduce_34

action_119 _ = happyReduce_36

action_120 (57) = happyShift action_21
action_120 (12) = happyGoto action_126
action_120 _ = happyReduce_31

action_121 (63) = happyShift action_125
action_121 _ = happyReduce_42

action_122 _ = happyReduce_37

action_123 (24) = happyShift action_40
action_123 (25) = happyShift action_41
action_123 (54) = happyShift action_88
action_123 (55) = happyShift action_42
action_123 (70) = happyShift action_43
action_123 (93) = happyShift action_44
action_123 (96) = happyShift action_19
action_123 (97) = happyShift action_45
action_123 (98) = happyShift action_46
action_123 (10) = happyGoto action_31
action_123 (11) = happyGoto action_86
action_123 (13) = happyGoto action_33
action_123 (14) = happyGoto action_124
action_123 (15) = happyGoto action_34
action_123 (16) = happyGoto action_35
action_123 (17) = happyGoto action_36
action_123 (18) = happyGoto action_37
action_123 (19) = happyGoto action_38
action_123 (20) = happyGoto action_39
action_123 _ = happyFail (happyExpListPerState 123)

action_124 _ = happyReduce_39

action_125 (24) = happyShift action_40
action_125 (25) = happyShift action_41
action_125 (54) = happyShift action_88
action_125 (55) = happyShift action_42
action_125 (70) = happyShift action_43
action_125 (93) = happyShift action_44
action_125 (96) = happyShift action_19
action_125 (97) = happyShift action_45
action_125 (98) = happyShift action_46
action_125 (10) = happyGoto action_31
action_125 (11) = happyGoto action_86
action_125 (13) = happyGoto action_33
action_125 (14) = happyGoto action_127
action_125 (15) = happyGoto action_34
action_125 (16) = happyGoto action_35
action_125 (17) = happyGoto action_36
action_125 (18) = happyGoto action_37
action_125 (19) = happyGoto action_38
action_125 (20) = happyGoto action_39
action_125 _ = happyFail (happyExpListPerState 125)

action_126 _ = happyReduce_32

action_127 _ = happyReduce_41

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
happyReduction_24 (HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn11
		 (Other happy_var_1
	)
happyReduction_24 _  = notHappyAtAll 

happyReduce_25 = happySpecReduce_1  11 happyReduction_25
happyReduction_25 (HappyAbsSyn16  happy_var_1)
	 =  HappyAbsSyn11
		 (Bool happy_var_1
	)
happyReduction_25 _  = notHappyAtAll 

happyReduce_26 = happySpecReduce_1  11 happyReduction_26
happyReduction_26 (HappyAbsSyn19  happy_var_1)
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
	(HappyAbsSyn19  happy_var_2)
	_
	 =  HappyAbsSyn12
		 (Index happy_var_2
	)
happyReduction_29 _ _ _  = notHappyAtAll 

happyReduce_30 = happyReduce 4 12 happyReduction_30
happyReduction_30 ((HappyAbsSyn12  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn19  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn12
		 (ManyAc (Index happy_var_2) happy_var_4
	) `HappyStk` happyRest

happyReduce_31 = happyReduce 5 12 happyReduction_31
happyReduction_31 (_ `HappyStk`
	(HappyAbsSyn19  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn19  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn12
		 (Interval happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_32 = happyReduce 6 12 happyReduction_32
happyReduction_32 ((HappyAbsSyn12  happy_var_6) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn19  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn19  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn12
		 (ManyAc (Interval happy_var_2 happy_var_4) happy_var_6
	) `HappyStk` happyRest

happyReduce_33 = happyReduce 4 12 happyReduction_33
happyReduction_33 (_ `HappyStk`
	(HappyAbsSyn19  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn12
		 (Interval (IntLit 0) happy_var_3
	) `HappyStk` happyRest

happyReduce_34 = happyReduce 5 12 happyReduction_34
happyReduction_34 ((HappyAbsSyn12  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn19  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn12
		 (ManyAc (Interval (IntLit 0) happy_var_3) happy_var_5
	) `HappyStk` happyRest

happyReduce_35 = happyReduce 4 12 happyReduction_35
happyReduction_35 (_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn19  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn12
		 (Begin happy_var_2
	) `HappyStk` happyRest

happyReduce_36 = happyReduce 5 12 happyReduction_36
happyReduction_36 ((HappyAbsSyn12  happy_var_5) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn19  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn12
		 (ManyAc (Begin happy_var_2) happy_var_5
	) `HappyStk` happyRest

happyReduce_37 = happyReduce 4 13 happyReduction_37
happyReduction_37 (_ `HappyStk`
	(HappyAbsSyn14  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn10  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn13
		 (Funcall happy_var_1 happy_var_3
	) `HappyStk` happyRest

happyReduce_38 = happySpecReduce_3  13 happyReduction_38
happyReduction_38 _
	_
	(HappyAbsSyn10  happy_var_1)
	 =  HappyAbsSyn13
		 (Funcall happy_var_1 NoArgs
	)
happyReduction_38 _ _ _  = notHappyAtAll 

happyReduce_39 = happySpecReduce_3  14 happyReduction_39
happyReduction_39 (HappyAbsSyn14  happy_var_3)
	_
	(HappyAbsSyn11  happy_var_1)
	 =  HappyAbsSyn14
		 (KArgs (Arg True happy_var_1) happy_var_3
	)
happyReduction_39 _ _ _  = notHappyAtAll 

happyReduce_40 = happySpecReduce_1  14 happyReduction_40
happyReduction_40 (HappyAbsSyn11  happy_var_1)
	 =  HappyAbsSyn14
		 (Arg False happy_var_1
	)
happyReduction_40 _  = notHappyAtAll 

happyReduce_41 = happyReduce 4 14 happyReduction_41
happyReduction_41 ((HappyAbsSyn14  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn11  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn14
		 (KArgs (Arg True happy_var_2) happy_var_4
	) `HappyStk` happyRest

happyReduce_42 = happySpecReduce_2  14 happyReduction_42
happyReduction_42 (HappyAbsSyn11  happy_var_2)
	_
	 =  HappyAbsSyn14
		 (Arg True happy_var_2
	)
happyReduction_42 _ _  = notHappyAtAll 

happyReduce_43 = happySpecReduce_1  15 happyReduction_43
happyReduction_43 (HappyAbsSyn13  happy_var_1)
	 =  HappyAbsSyn15
		 (happy_var_1
	)
happyReduction_43 _  = notHappyAtAll 

happyReduce_44 = happySpecReduce_1  15 happyReduction_44
happyReduction_44 (HappyAbsSyn10  happy_var_1)
	 =  HappyAbsSyn15
		 (ExpWha happy_var_1
	)
happyReduction_44 _  = notHappyAtAll 

happyReduce_45 = happySpecReduce_1  16 happyReduction_45
happyReduction_45 (HappyAbsSyn17  happy_var_1)
	 =  HappyAbsSyn16
		 (happy_var_1
	)
happyReduction_45 _  = notHappyAtAll 

happyReduce_46 = happySpecReduce_3  16 happyReduction_46
happyReduction_46 (HappyAbsSyn16  happy_var_3)
	_
	(HappyAbsSyn18  happy_var_1)
	 =  HappyAbsSyn16
		 (And happy_var_1 happy_var_3
	)
happyReduction_46 _ _ _  = notHappyAtAll 

happyReduce_47 = happySpecReduce_3  16 happyReduction_47
happyReduction_47 (HappyAbsSyn16  happy_var_3)
	_
	(HappyAbsSyn18  happy_var_1)
	 =  HappyAbsSyn16
		 (Bitand happy_var_1 happy_var_3
	)
happyReduction_47 _ _ _  = notHappyAtAll 

happyReduce_48 = happySpecReduce_3  16 happyReduction_48
happyReduction_48 (HappyAbsSyn16  happy_var_3)
	_
	(HappyAbsSyn18  happy_var_1)
	 =  HappyAbsSyn16
		 (Or happy_var_1 happy_var_3
	)
happyReduction_48 _ _ _  = notHappyAtAll 

happyReduce_49 = happySpecReduce_3  16 happyReduction_49
happyReduction_49 (HappyAbsSyn16  happy_var_3)
	_
	(HappyAbsSyn18  happy_var_1)
	 =  HappyAbsSyn16
		 (Bitor happy_var_1 happy_var_3
	)
happyReduction_49 _ _ _  = notHappyAtAll 

happyReduce_50 = happySpecReduce_2  16 happyReduction_50
happyReduction_50 (HappyAbsSyn16  happy_var_2)
	_
	 =  HappyAbsSyn16
		 (Not happy_var_2
	)
happyReduction_50 _ _  = notHappyAtAll 

happyReduce_51 = happySpecReduce_3  16 happyReduction_51
happyReduction_51 (HappyAbsSyn15  happy_var_3)
	_
	(HappyAbsSyn18  happy_var_1)
	 =  HappyAbsSyn16
		 (And happy_var_1 (LBool happy_var_3)
	)
happyReduction_51 _ _ _  = notHappyAtAll 

happyReduce_52 = happySpecReduce_3  16 happyReduction_52
happyReduction_52 (HappyAbsSyn15  happy_var_3)
	_
	(HappyAbsSyn18  happy_var_1)
	 =  HappyAbsSyn16
		 (Bitand happy_var_1 (LBool happy_var_3)
	)
happyReduction_52 _ _ _  = notHappyAtAll 

happyReduce_53 = happySpecReduce_3  16 happyReduction_53
happyReduction_53 (HappyAbsSyn15  happy_var_3)
	_
	(HappyAbsSyn18  happy_var_1)
	 =  HappyAbsSyn16
		 (Or happy_var_1 (LBool happy_var_3)
	)
happyReduction_53 _ _ _  = notHappyAtAll 

happyReduce_54 = happySpecReduce_3  16 happyReduction_54
happyReduction_54 (HappyAbsSyn15  happy_var_3)
	_
	(HappyAbsSyn18  happy_var_1)
	 =  HappyAbsSyn16
		 (Bitor happy_var_1 (LBool happy_var_3)
	)
happyReduction_54 _ _ _  = notHappyAtAll 

happyReduce_55 = happySpecReduce_2  16 happyReduction_55
happyReduction_55 (HappyAbsSyn15  happy_var_2)
	_
	 =  HappyAbsSyn16
		 (Not (LBool happy_var_2)
	)
happyReduction_55 _ _  = notHappyAtAll 

happyReduce_56 = happySpecReduce_3  16 happyReduction_56
happyReduction_56 _
	(HappyAbsSyn16  happy_var_2)
	_
	 =  HappyAbsSyn16
		 (happy_var_2
	)
happyReduction_56 _ _ _  = notHappyAtAll 

happyReduce_57 = happySpecReduce_1  17 happyReduction_57
happyReduction_57 _
	 =  HappyAbsSyn17
		 (New
	)

happyReduce_58 = happySpecReduce_1  17 happyReduction_58
happyReduction_58 _
	 =  HappyAbsSyn17
		 (Full
	)

happyReduce_59 = happySpecReduce_1  18 happyReduction_59
happyReduction_59 (HappyAbsSyn17  happy_var_1)
	 =  HappyAbsSyn18
		 (happy_var_1
	)
happyReduction_59 _  = notHappyAtAll 

happyReduce_60 = happySpecReduce_1  18 happyReduction_60
happyReduction_60 (HappyAbsSyn10  happy_var_1)
	 =  HappyAbsSyn18
		 (LBool (ExpWha happy_var_1)
	)
happyReduction_60 _  = notHappyAtAll 

happyReduce_61 = happySpecReduce_3  18 happyReduction_61
happyReduction_61 _
	(HappyAbsSyn16  happy_var_2)
	_
	 =  HappyAbsSyn18
		 (happy_var_2
	)
happyReduction_61 _ _ _  = notHappyAtAll 

happyReduce_62 = happySpecReduce_1  19 happyReduction_62
happyReduction_62 (HappyTerminal (TkInt happy_var_1))
	 =  HappyAbsSyn19
		 (IntLit (fst happy_var_1)
	)
happyReduction_62 _  = notHappyAtAll 

happyReduce_63 = happySpecReduce_1  19 happyReduction_63
happyReduction_63 (HappyTerminal (TkFloat happy_var_1))
	 =  HappyAbsSyn19
		 (FloLit (fst happy_var_1)
	)
happyReduction_63 _  = notHappyAtAll 

happyReduce_64 = happySpecReduce_3  19 happyReduction_64
happyReduction_64 (HappyAbsSyn19  happy_var_3)
	_
	(HappyAbsSyn20  happy_var_1)
	 =  HappyAbsSyn19
		 (Sum happy_var_1 happy_var_3
	)
happyReduction_64 _ _ _  = notHappyAtAll 

happyReduce_65 = happySpecReduce_3  19 happyReduction_65
happyReduction_65 (HappyAbsSyn19  happy_var_3)
	_
	(HappyAbsSyn20  happy_var_1)
	 =  HappyAbsSyn19
		 (Sub happy_var_1 happy_var_3
	)
happyReduction_65 _ _ _  = notHappyAtAll 

happyReduce_66 = happySpecReduce_3  19 happyReduction_66
happyReduction_66 (HappyAbsSyn19  happy_var_3)
	_
	(HappyAbsSyn20  happy_var_1)
	 =  HappyAbsSyn19
		 (Mul happy_var_1 happy_var_3
	)
happyReduction_66 _ _ _  = notHappyAtAll 

happyReduce_67 = happySpecReduce_3  19 happyReduction_67
happyReduction_67 (HappyAbsSyn19  happy_var_3)
	_
	(HappyAbsSyn20  happy_var_1)
	 =  HappyAbsSyn19
		 (Pow happy_var_1 happy_var_3
	)
happyReduction_67 _ _ _  = notHappyAtAll 

happyReduce_68 = happySpecReduce_3  19 happyReduction_68
happyReduction_68 (HappyAbsSyn19  happy_var_3)
	_
	(HappyAbsSyn20  happy_var_1)
	 =  HappyAbsSyn19
		 (Div happy_var_1 happy_var_3
	)
happyReduction_68 _ _ _  = notHappyAtAll 

happyReduce_69 = happySpecReduce_3  19 happyReduction_69
happyReduction_69 (HappyAbsSyn19  happy_var_3)
	_
	(HappyAbsSyn20  happy_var_1)
	 =  HappyAbsSyn19
		 (Mod happy_var_1 happy_var_3
	)
happyReduction_69 _ _ _  = notHappyAtAll 

happyReduce_70 = happySpecReduce_2  19 happyReduction_70
happyReduction_70 (HappyAbsSyn19  happy_var_2)
	_
	 =  HappyAbsSyn19
		 (Neg happy_var_2
	)
happyReduction_70 _ _  = notHappyAtAll 

happyReduce_71 = happySpecReduce_3  19 happyReduction_71
happyReduction_71 (HappyAbsSyn10  happy_var_3)
	_
	(HappyAbsSyn20  happy_var_1)
	 =  HappyAbsSyn19
		 (Sum happy_var_1 (LNum happy_var_3)
	)
happyReduction_71 _ _ _  = notHappyAtAll 

happyReduce_72 = happySpecReduce_3  19 happyReduction_72
happyReduction_72 (HappyAbsSyn10  happy_var_3)
	_
	(HappyAbsSyn20  happy_var_1)
	 =  HappyAbsSyn19
		 (Sub happy_var_1 (LNum happy_var_3)
	)
happyReduction_72 _ _ _  = notHappyAtAll 

happyReduce_73 = happySpecReduce_3  19 happyReduction_73
happyReduction_73 (HappyAbsSyn10  happy_var_3)
	_
	(HappyAbsSyn20  happy_var_1)
	 =  HappyAbsSyn19
		 (Mul happy_var_1 (LNum happy_var_3)
	)
happyReduction_73 _ _ _  = notHappyAtAll 

happyReduce_74 = happySpecReduce_3  19 happyReduction_74
happyReduction_74 (HappyAbsSyn10  happy_var_3)
	_
	(HappyAbsSyn20  happy_var_1)
	 =  HappyAbsSyn19
		 (Pow happy_var_1 (LNum happy_var_3)
	)
happyReduction_74 _ _ _  = notHappyAtAll 

happyReduce_75 = happySpecReduce_3  19 happyReduction_75
happyReduction_75 (HappyAbsSyn10  happy_var_3)
	_
	(HappyAbsSyn20  happy_var_1)
	 =  HappyAbsSyn19
		 (Div happy_var_1 (LNum happy_var_3)
	)
happyReduction_75 _ _ _  = notHappyAtAll 

happyReduce_76 = happySpecReduce_3  19 happyReduction_76
happyReduction_76 (HappyAbsSyn10  happy_var_3)
	_
	(HappyAbsSyn20  happy_var_1)
	 =  HappyAbsSyn19
		 (Mod happy_var_1 (LNum happy_var_3)
	)
happyReduction_76 _ _ _  = notHappyAtAll 

happyReduce_77 = happySpecReduce_2  19 happyReduction_77
happyReduction_77 (HappyAbsSyn10  happy_var_2)
	_
	 =  HappyAbsSyn19
		 (Neg (LNum happy_var_2)
	)
happyReduction_77 _ _  = notHappyAtAll 

happyReduce_78 = happySpecReduce_3  19 happyReduction_78
happyReduction_78 _
	(HappyAbsSyn19  happy_var_2)
	_
	 =  HappyAbsSyn19
		 (happy_var_2
	)
happyReduction_78 _ _ _  = notHappyAtAll 

happyReduce_79 = happySpecReduce_1  20 happyReduction_79
happyReduction_79 (HappyTerminal (TkInt happy_var_1))
	 =  HappyAbsSyn20
		 (IntLit (fst happy_var_1)
	)
happyReduction_79 _  = notHappyAtAll 

happyReduce_80 = happySpecReduce_1  20 happyReduction_80
happyReduction_80 (HappyTerminal (TkFloat happy_var_1))
	 =  HappyAbsSyn20
		 (FloLit (fst happy_var_1)
	)
happyReduction_80 _  = notHappyAtAll 

happyReduce_81 = happySpecReduce_1  20 happyReduction_81
happyReduction_81 (HappyAbsSyn10  happy_var_1)
	 =  HappyAbsSyn20
		 (LNum happy_var_1
	)
happyReduction_81 _  = notHappyAtAll 

happyReduce_82 = happySpecReduce_3  20 happyReduction_82
happyReduction_82 _
	(HappyAbsSyn19  happy_var_2)
	_
	 =  HappyAbsSyn20
		 (happy_var_2
	)
happyReduction_82 _ _ _  = notHappyAtAll 

happyNewToken action sts stk [] =
	action 99 99 notHappyAtAll (HappyState action) sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = action i i tk (HappyState action) sts stk tks in
	case tk of {
	TkSpace     happy_dollar_dollar -> cont 21;
	TkEndofSpace happy_dollar_dollar -> cont 22;
	TkMoon      happy_dollar_dollar -> cont 23;
	TkNew       happy_dollar_dollar -> cont 24;
	TkFull      happy_dollar_dollar -> cont 25;
	TkPlanet    happy_dollar_dollar -> cont 26;
	TkCloud     happy_dollar_dollar -> cont 27;
	TkStar      happy_dollar_dollar -> cont 28;
	TkBlackhole happy_dollar_dollar -> cont 29;
	TkCosmos    happy_dollar_dollar -> cont 30;
	TkConstellation happy_dollar_dollar -> cont 31;
	TkCluster   happy_dollar_dollar -> cont 32;
	TkQuasar    happy_dollar_dollar -> cont 33;
	TkNebula    happy_dollar_dollar -> cont 34;
	TkGalaxy    happy_dollar_dollar -> cont 35;
	TkUFO       happy_dollar_dollar -> cont 36;
	TkComet     happy_dollar_dollar -> cont 37;
	TkSatellite happy_dollar_dollar -> cont 38;
	TkTerraform happy_dollar_dollar -> cont 39;
	TkPrint     happy_dollar_dollar -> cont 40;
	TkRead      happy_dollar_dollar -> cont 41;
	TkAround    happy_dollar_dollar -> cont 42;
	TkRange     happy_dollar_dollar -> cont 43;
	TkPop       happy_dollar_dollar -> cont 44;
	TkAdd       happy_dollar_dollar -> cont 45;
	TkBigbang   happy_dollar_dollar -> cont 46;
	TkIf        happy_dollar_dollar -> cont 47;
	TkElseif    happy_dollar_dollar -> cont 48;
	TkElse      happy_dollar_dollar -> cont 49;
	TkUnless    happy_dollar_dollar -> cont 50;
	TkWhile     happy_dollar_dollar -> cont 51;
	TkUntil     happy_dollar_dollar -> cont 52;
	TkOrbit     happy_dollar_dollar -> cont 53;
	TkArroba      happy_dollar_dollar -> cont 54;
	TkParA      happy_dollar_dollar -> cont 55;
	TkParC      happy_dollar_dollar -> cont 56;
	TkCorA      happy_dollar_dollar -> cont 57;
	TkCorC      happy_dollar_dollar -> cont 58;
	TkLlavA     happy_dollar_dollar -> cont 59;
	TkLlavC     happy_dollar_dollar -> cont 60;
	TkPuntopunto happy_dollar_dollar -> cont 61;
	TkPunto     happy_dollar_dollar -> cont 62;
	TkComa      happy_dollar_dollar -> cont 63;
	TkPuntoycoma happy_dollar_dollar -> cont 64;
	TkDospuntos happy_dollar_dollar -> cont 65;
	TkNyangara  happy_dollar_dollar -> cont 66;
	TkMasIgual  happy_dollar_dollar -> cont 67;
	TkMas       happy_dollar_dollar -> cont 68;
	TkMenosIgual happy_dollar_dollar -> cont 69;
	TkMenos     happy_dollar_dollar -> cont 70;
	TkMultIgual happy_dollar_dollar -> cont 71;
	TkMult     happy_dollar_dollar -> cont 72;
	TkPotenciaIgual happy_dollar_dollar -> cont 73;
	TkPotencia  happy_dollar_dollar -> cont 74;
	TkDivEnteraIgual happy_dollar_dollar -> cont 75;
	TkDivEntera happy_dollar_dollar -> cont 76;
	TkDivIgual  happy_dollar_dollar -> cont 77;
	TkDiv       happy_dollar_dollar -> cont 78;
	TkModIgual  happy_dollar_dollar -> cont 79;
	TkMod       happy_dollar_dollar -> cont 80;
	TkFlechita  happy_dollar_dollar -> cont 81;
	TkMayorIgual happy_dollar_dollar -> cont 82;
	TkMayor     happy_dollar_dollar -> cont 83;
	TkMenorIgual happy_dollar_dollar -> cont 84;
	TkMenor     happy_dollar_dollar -> cont 85;
	TkAnd       happy_dollar_dollar -> cont 86;
	TkBitand    happy_dollar_dollar -> cont 87;
	TkOr        happy_dollar_dollar -> cont 88;
	TkBitor     happy_dollar_dollar -> cont 89;
	TkIgual     happy_dollar_dollar -> cont 90;
	TkDistinto  happy_dollar_dollar -> cont 91;
	TkAsignacion happy_dollar_dollar -> cont 92;
	TkNegacion  happy_dollar_dollar -> cont 93;
	TkString happy_dollar_dollar -> cont 94;
	TkChar happy_dollar_dollar -> cont 95;
	TkId happy_dollar_dollar -> cont 96;
	TkFloat happy_dollar_dollar -> cont 97;
	TkInt happy_dollar_dollar -> cont 98;
	_ -> happyError' ((tk:tks), [])
	}

happyError_ explist 99 tk tks = happyError' (tks, explist)
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
      = Other Exp
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

data Args
      = NoArgs
      | Arg Bool RValue
      | KArgs Args Args 
      deriving Show

data Exp
      = Funcall LValue Args
      | ExpWha LValue
      deriving Show

data ExpBool
      = New
      | Full
      | And ExpBool ExpBool
      | Bitand ExpBool ExpBool
      | Or ExpBool ExpBool
      | Bitor ExpBool ExpBool
      | Not ExpBool
      | LBool Exp
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
