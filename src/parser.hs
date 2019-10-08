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
happyExpList = Happy_Data_Array.listArray (0,619) ([0,2,0,0,0,0,0,2,0,0,0,0,0,4,0,0,0,0,0,0,0,0,0,0,0,460,18432,16424,0,4096,0,4,0,0,0,0,0,0,0,4096,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4096,0,0,0,0,0,0,0,0,0,33824,2730,256,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,0,0,0,0,0,8,0,0,0,0,0,8,0,4096,0,456,0,16416,0,0,0,456,0,16416,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,64,0,0,0,0,0,1072,0,0,0,48,0,8,4,32256,0,48,0,8,4,32256,0,0,0,0,0,0,0,48,0,520,4,32256,0,0,0,0,0,4096,0,48,0,8,4,32256,0,48,0,8,4,32256,0,48,0,8,4,32256,0,48,0,8,4,32256,0,48,0,8,4,32256,0,48,0,8,4,32256,0,48,0,8,4,32256,0,48,0,8,4,32256,0,0,0,0,0,0,0,456,18432,16424,0,4096,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1064,0,0,0,0,0,0,54613,255,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,48,0,8,4,32256,0,48,0,8,4,32256,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,54613,255,0,0,0,0,54613,255,0,0,0,0,54613,255,0,0,0,0,54613,255,0,0,0,0,54613,255,0,0,0,0,54613,255,0,0,0,0,54613,255,0,0,0,0,0,0,0,0,0,576,54613,255,0,48,0,8,4,32256,0,0,0,16,54613,255,0,0,0,16,54613,255,0,0,0,0,0,0,0,28672,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,128,0,0,0,48,0,8,4,32256,0,48,0,8,4,32256,0,48,0,8,4,32256,0,48,0,8,4,32256,0,48,0,8,4,32256,0,48,0,8,4,32256,0,48,0,8,4,32256,0,48,0,8,4,32256,0,48,0,8,4,32256,0,48,0,8,4,32256,0,48,0,8,4,32256,0,48,0,8,4,32256,0,48,0,8,4,32256,0,48,0,8,4,32256,0,48,0,8,4,32256,0,48,0,8,4,32256,0,48,0,8,4,32256,0,0,0,128,0,0,0,0,0,64,54613,255,0,0,0,0,0,0,0,48,0,72,4,32256,0,0,0,0,5461,0,0,0,0,0,0,0,0,48,0,24,4,32256,0,0,0,2048,54613,255,0,0,0,16,0,0,0,0,0,0,0,0,0,0,0,64,54613,255,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,456,18432,16424,0,4096,0,0,0,0,5461,60,0,0,0,0,5461,60,0,0,0,0,5461,0,0,0,0,0,5461,0,0,0,0,0,5461,0,0,0,0,0,5461,0,0,0,0,0,5461,60,0,0,0,0,5461,60,0,0,0,0,5461,60,0,0,0,0,5461,60,0,0,0,0,64,0,0,0,0,0,64,0,0,0,0,0,64,0,0,0,0,0,0,0,0,0,0,0,64,0,0,0,0,0,5456,0,0,0,0,0,5456,0,0,456,18432,16424,0,4096,0,0,0,256,0,0,0,0,0,256,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,48,0,8,4,32256,0,0,0,0,0,0,0,0,0,0,0,0,0,0,12288,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,0,0,0,0,0,128,0,0,0,456,18432,16424,0,4096,0,48,0,8,4,32256,0,0,0,16,54613,255,0,0,0,256,0,0,0,0,0,0,0,0,0,0,0,128,0,0,0,456,18432,16424,0,4096,0,0,0,256,0,0,0,0,12288,0,0,0,0,0,0,0,0,0,0
	])

{-# NOINLINE happyExpListPerState #-}
happyExpListPerState st =
    token_strs_expected
  where token_strs = ["error","%dummy","%start_midnight","S","Seq","Instr","If","Elif","Declar","Type","TComp","LValue","Exp","Slice","Funcall","Args","Params","space","end","moon","new","full","planet","cloud","star","blackhole","cosmos","constellation","cluster","quasar","nebula","galaxy","ufo","comet","satellite","terraform","print","read","around","range","pop","add","bigbang","if","elseif","else","unless","while","until","orbit","'@'","'('","')'","'['","']'","'{'","'}'","'..'","'.'","','","';'","':'","'~'","'+='","'+'","'-='","'-'","'*='","'*'","'^='","'^'","'//='","'//'","'/='","'/'","'%='","'%'","'->'","'>='","'>'","'<='","'<'","'&&'","'&'","'||'","'|'","'=='","'\9516\188='","'='","'\9516\188'","str","chr","id","float","int","%eof"]
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

action_2 (19) = happyShift action_12
action_2 _ = happyFail (happyExpListPerState 2)

action_3 (96) = happyAccept
action_3 _ = happyFail (happyExpListPerState 3)

action_4 (19) = happyShift action_12
action_4 (20) = happyShift action_13
action_4 (23) = happyShift action_14
action_4 (24) = happyShift action_15
action_4 (25) = happyShift action_16
action_4 (44) = happyShift action_17
action_4 (47) = happyShift action_18
action_4 (52) = happyShift action_19
action_4 (54) = happyShift action_20
action_4 (63) = happyShift action_21
action_4 (93) = happyShift action_22
action_4 (5) = happyGoto action_5
action_4 (6) = happyGoto action_6
action_4 (7) = happyGoto action_7
action_4 (9) = happyGoto action_8
action_4 (10) = happyGoto action_9
action_4 (11) = happyGoto action_10
action_4 (12) = happyGoto action_11
action_4 _ = happyFail (happyExpListPerState 4)

action_5 (19) = happyShift action_41
action_5 _ = happyFail (happyExpListPerState 5)

action_6 (61) = happyShift action_40
action_6 _ = happyReduce_3

action_7 _ = happyReduce_15

action_8 _ = happyReduce_6

action_9 (93) = happyShift action_39
action_9 _ = happyFail (happyExpListPerState 9)

action_10 _ = happyReduce_27

action_11 (54) = happyShift action_29
action_11 (59) = happyShift action_30
action_11 (64) = happyShift action_31
action_11 (66) = happyShift action_32
action_11 (68) = happyShift action_33
action_11 (70) = happyShift action_34
action_11 (72) = happyShift action_35
action_11 (74) = happyShift action_36
action_11 (76) = happyShift action_37
action_11 (89) = happyShift action_38
action_11 (14) = happyGoto action_28
action_11 _ = happyFail (happyExpListPerState 11)

action_12 _ = happyReduce_1

action_13 _ = happyReduce_26

action_14 _ = happyReduce_23

action_15 _ = happyReduce_24

action_16 _ = happyReduce_25

action_17 (52) = happyShift action_27
action_17 _ = happyFail (happyExpListPerState 17)

action_18 (52) = happyShift action_26
action_18 _ = happyFail (happyExpListPerState 18)

action_19 (52) = happyShift action_19
action_19 (93) = happyShift action_22
action_19 (12) = happyGoto action_25
action_19 _ = happyFail (happyExpListPerState 19)

action_20 (20) = happyShift action_13
action_20 (23) = happyShift action_14
action_20 (24) = happyShift action_15
action_20 (25) = happyShift action_16
action_20 (54) = happyShift action_20
action_20 (63) = happyShift action_21
action_20 (10) = happyGoto action_24
action_20 (11) = happyGoto action_10
action_20 _ = happyFail (happyExpListPerState 20)

action_21 (20) = happyShift action_13
action_21 (23) = happyShift action_14
action_21 (24) = happyShift action_15
action_21 (25) = happyShift action_16
action_21 (54) = happyShift action_20
action_21 (63) = happyShift action_21
action_21 (10) = happyGoto action_23
action_21 (11) = happyGoto action_10
action_21 _ = happyFail (happyExpListPerState 21)

action_22 _ = happyReduce_32

action_23 _ = happyReduce_31

action_24 (55) = happyShift action_67
action_24 _ = happyFail (happyExpListPerState 24)

action_25 (53) = happyShift action_66
action_25 (54) = happyShift action_29
action_25 (59) = happyShift action_30
action_25 (14) = happyGoto action_28
action_25 _ = happyFail (happyExpListPerState 25)

action_26 (21) = happyShift action_46
action_26 (22) = happyShift action_47
action_26 (52) = happyShift action_19
action_26 (67) = happyShift action_48
action_26 (90) = happyShift action_49
action_26 (91) = happyShift action_50
action_26 (92) = happyShift action_51
action_26 (93) = happyShift action_22
action_26 (94) = happyShift action_52
action_26 (95) = happyShift action_53
action_26 (12) = happyGoto action_43
action_26 (13) = happyGoto action_65
action_26 (15) = happyGoto action_45
action_26 _ = happyFail (happyExpListPerState 26)

action_27 (21) = happyShift action_46
action_27 (22) = happyShift action_47
action_27 (52) = happyShift action_19
action_27 (67) = happyShift action_48
action_27 (90) = happyShift action_49
action_27 (91) = happyShift action_50
action_27 (92) = happyShift action_51
action_27 (93) = happyShift action_22
action_27 (94) = happyShift action_52
action_27 (95) = happyShift action_53
action_27 (12) = happyGoto action_43
action_27 (13) = happyGoto action_64
action_27 (15) = happyGoto action_45
action_27 _ = happyFail (happyExpListPerState 27)

action_28 _ = happyReduce_34

action_29 (21) = happyShift action_46
action_29 (22) = happyShift action_47
action_29 (52) = happyShift action_19
action_29 (58) = happyShift action_63
action_29 (67) = happyShift action_48
action_29 (90) = happyShift action_49
action_29 (91) = happyShift action_50
action_29 (92) = happyShift action_51
action_29 (93) = happyShift action_22
action_29 (94) = happyShift action_52
action_29 (95) = happyShift action_53
action_29 (12) = happyGoto action_43
action_29 (13) = happyGoto action_62
action_29 (15) = happyGoto action_45
action_29 _ = happyFail (happyExpListPerState 29)

action_30 (93) = happyShift action_61
action_30 _ = happyFail (happyExpListPerState 30)

action_31 (21) = happyShift action_46
action_31 (22) = happyShift action_47
action_31 (52) = happyShift action_19
action_31 (67) = happyShift action_48
action_31 (90) = happyShift action_49
action_31 (91) = happyShift action_50
action_31 (92) = happyShift action_51
action_31 (93) = happyShift action_22
action_31 (94) = happyShift action_52
action_31 (95) = happyShift action_53
action_31 (12) = happyGoto action_43
action_31 (13) = happyGoto action_60
action_31 (15) = happyGoto action_45
action_31 _ = happyFail (happyExpListPerState 31)

action_32 (21) = happyShift action_46
action_32 (22) = happyShift action_47
action_32 (52) = happyShift action_19
action_32 (67) = happyShift action_48
action_32 (90) = happyShift action_49
action_32 (91) = happyShift action_50
action_32 (92) = happyShift action_51
action_32 (93) = happyShift action_22
action_32 (94) = happyShift action_52
action_32 (95) = happyShift action_53
action_32 (12) = happyGoto action_43
action_32 (13) = happyGoto action_59
action_32 (15) = happyGoto action_45
action_32 _ = happyFail (happyExpListPerState 32)

action_33 (21) = happyShift action_46
action_33 (22) = happyShift action_47
action_33 (52) = happyShift action_19
action_33 (67) = happyShift action_48
action_33 (90) = happyShift action_49
action_33 (91) = happyShift action_50
action_33 (92) = happyShift action_51
action_33 (93) = happyShift action_22
action_33 (94) = happyShift action_52
action_33 (95) = happyShift action_53
action_33 (12) = happyGoto action_43
action_33 (13) = happyGoto action_58
action_33 (15) = happyGoto action_45
action_33 _ = happyFail (happyExpListPerState 33)

action_34 (21) = happyShift action_46
action_34 (22) = happyShift action_47
action_34 (52) = happyShift action_19
action_34 (67) = happyShift action_48
action_34 (90) = happyShift action_49
action_34 (91) = happyShift action_50
action_34 (92) = happyShift action_51
action_34 (93) = happyShift action_22
action_34 (94) = happyShift action_52
action_34 (95) = happyShift action_53
action_34 (12) = happyGoto action_43
action_34 (13) = happyGoto action_57
action_34 (15) = happyGoto action_45
action_34 _ = happyFail (happyExpListPerState 34)

action_35 (21) = happyShift action_46
action_35 (22) = happyShift action_47
action_35 (52) = happyShift action_19
action_35 (67) = happyShift action_48
action_35 (90) = happyShift action_49
action_35 (91) = happyShift action_50
action_35 (92) = happyShift action_51
action_35 (93) = happyShift action_22
action_35 (94) = happyShift action_52
action_35 (95) = happyShift action_53
action_35 (12) = happyGoto action_43
action_35 (13) = happyGoto action_56
action_35 (15) = happyGoto action_45
action_35 _ = happyFail (happyExpListPerState 35)

action_36 (21) = happyShift action_46
action_36 (22) = happyShift action_47
action_36 (52) = happyShift action_19
action_36 (67) = happyShift action_48
action_36 (90) = happyShift action_49
action_36 (91) = happyShift action_50
action_36 (92) = happyShift action_51
action_36 (93) = happyShift action_22
action_36 (94) = happyShift action_52
action_36 (95) = happyShift action_53
action_36 (12) = happyGoto action_43
action_36 (13) = happyGoto action_55
action_36 (15) = happyGoto action_45
action_36 _ = happyFail (happyExpListPerState 36)

action_37 (21) = happyShift action_46
action_37 (22) = happyShift action_47
action_37 (52) = happyShift action_19
action_37 (67) = happyShift action_48
action_37 (90) = happyShift action_49
action_37 (91) = happyShift action_50
action_37 (92) = happyShift action_51
action_37 (93) = happyShift action_22
action_37 (94) = happyShift action_52
action_37 (95) = happyShift action_53
action_37 (12) = happyGoto action_43
action_37 (13) = happyGoto action_54
action_37 (15) = happyGoto action_45
action_37 _ = happyFail (happyExpListPerState 37)

action_38 (21) = happyShift action_46
action_38 (22) = happyShift action_47
action_38 (52) = happyShift action_19
action_38 (67) = happyShift action_48
action_38 (90) = happyShift action_49
action_38 (91) = happyShift action_50
action_38 (92) = happyShift action_51
action_38 (93) = happyShift action_22
action_38 (94) = happyShift action_52
action_38 (95) = happyShift action_53
action_38 (12) = happyGoto action_43
action_38 (13) = happyGoto action_44
action_38 (15) = happyGoto action_45
action_38 _ = happyFail (happyExpListPerState 38)

action_39 _ = happyReduce_22

action_40 (20) = happyShift action_13
action_40 (23) = happyShift action_14
action_40 (24) = happyShift action_15
action_40 (25) = happyShift action_16
action_40 (44) = happyShift action_17
action_40 (47) = happyShift action_18
action_40 (52) = happyShift action_19
action_40 (54) = happyShift action_20
action_40 (63) = happyShift action_21
action_40 (93) = happyShift action_22
action_40 (5) = happyGoto action_42
action_40 (6) = happyGoto action_6
action_40 (7) = happyGoto action_7
action_40 (9) = happyGoto action_8
action_40 (10) = happyGoto action_9
action_40 (11) = happyGoto action_10
action_40 (12) = happyGoto action_11
action_40 _ = happyReduce_4

action_41 _ = happyReduce_2

action_42 _ = happyReduce_5

action_43 (52) = happyShift action_95
action_43 (54) = happyShift action_29
action_43 (59) = happyShift action_30
action_43 (14) = happyGoto action_28
action_43 _ = happyReduce_37

action_44 (65) = happyShift action_72
action_44 (67) = happyShift action_73
action_44 (69) = happyShift action_74
action_44 (71) = happyShift action_75
action_44 (73) = happyShift action_76
action_44 (75) = happyShift action_77
action_44 (77) = happyShift action_78
action_44 (79) = happyShift action_79
action_44 (80) = happyShift action_80
action_44 (81) = happyShift action_81
action_44 (82) = happyShift action_82
action_44 (83) = happyShift action_83
action_44 (84) = happyShift action_84
action_44 (85) = happyShift action_85
action_44 (86) = happyShift action_86
action_44 (87) = happyShift action_87
action_44 (88) = happyShift action_88
action_44 _ = happyReduce_7

action_45 _ = happyReduce_36

action_46 _ = happyReduce_54

action_47 _ = happyReduce_55

action_48 (21) = happyShift action_46
action_48 (22) = happyShift action_47
action_48 (52) = happyShift action_19
action_48 (67) = happyShift action_48
action_48 (90) = happyShift action_49
action_48 (91) = happyShift action_50
action_48 (92) = happyShift action_51
action_48 (93) = happyShift action_22
action_48 (94) = happyShift action_52
action_48 (95) = happyShift action_53
action_48 (12) = happyGoto action_43
action_48 (13) = happyGoto action_94
action_48 (15) = happyGoto action_45
action_48 _ = happyFail (happyExpListPerState 48)

action_49 (21) = happyShift action_46
action_49 (22) = happyShift action_47
action_49 (52) = happyShift action_19
action_49 (67) = happyShift action_48
action_49 (90) = happyShift action_49
action_49 (91) = happyShift action_50
action_49 (92) = happyShift action_51
action_49 (93) = happyShift action_22
action_49 (94) = happyShift action_52
action_49 (95) = happyShift action_53
action_49 (12) = happyGoto action_43
action_49 (13) = happyGoto action_93
action_49 (15) = happyGoto action_45
action_49 _ = happyFail (happyExpListPerState 49)

action_50 _ = happyReduce_61

action_51 _ = happyReduce_62

action_52 _ = happyReduce_39

action_53 _ = happyReduce_38

action_54 (65) = happyShift action_72
action_54 (67) = happyShift action_73
action_54 (69) = happyShift action_74
action_54 (71) = happyShift action_75
action_54 (73) = happyShift action_76
action_54 (75) = happyShift action_77
action_54 (77) = happyShift action_78
action_54 (79) = happyShift action_79
action_54 (80) = happyShift action_80
action_54 (81) = happyShift action_81
action_54 (82) = happyShift action_82
action_54 (83) = happyShift action_83
action_54 (84) = happyShift action_84
action_54 (85) = happyShift action_85
action_54 (86) = happyShift action_86
action_54 (87) = happyShift action_87
action_54 (88) = happyShift action_88
action_54 _ = happyReduce_13

action_55 (65) = happyShift action_72
action_55 (67) = happyShift action_73
action_55 (69) = happyShift action_74
action_55 (71) = happyShift action_75
action_55 (73) = happyShift action_76
action_55 (75) = happyShift action_77
action_55 (77) = happyShift action_78
action_55 (79) = happyShift action_79
action_55 (80) = happyShift action_80
action_55 (81) = happyShift action_81
action_55 (82) = happyShift action_82
action_55 (83) = happyShift action_83
action_55 (84) = happyShift action_84
action_55 (85) = happyShift action_85
action_55 (86) = happyShift action_86
action_55 (87) = happyShift action_87
action_55 (88) = happyShift action_88
action_55 _ = happyReduce_11

action_56 (65) = happyShift action_72
action_56 (67) = happyShift action_73
action_56 (69) = happyShift action_74
action_56 (71) = happyShift action_75
action_56 (73) = happyShift action_76
action_56 (75) = happyShift action_77
action_56 (77) = happyShift action_78
action_56 (79) = happyShift action_79
action_56 (80) = happyShift action_80
action_56 (81) = happyShift action_81
action_56 (82) = happyShift action_82
action_56 (83) = happyShift action_83
action_56 (84) = happyShift action_84
action_56 (85) = happyShift action_85
action_56 (86) = happyShift action_86
action_56 (87) = happyShift action_87
action_56 (88) = happyShift action_88
action_56 _ = happyReduce_12

action_57 (65) = happyShift action_72
action_57 (67) = happyShift action_73
action_57 (69) = happyShift action_74
action_57 (71) = happyShift action_75
action_57 (73) = happyShift action_76
action_57 (75) = happyShift action_77
action_57 (77) = happyShift action_78
action_57 (79) = happyShift action_79
action_57 (80) = happyShift action_80
action_57 (81) = happyShift action_81
action_57 (82) = happyShift action_82
action_57 (83) = happyShift action_83
action_57 (84) = happyShift action_84
action_57 (85) = happyShift action_85
action_57 (86) = happyShift action_86
action_57 (87) = happyShift action_87
action_57 (88) = happyShift action_88
action_57 _ = happyReduce_14

action_58 (65) = happyShift action_72
action_58 (67) = happyShift action_73
action_58 (69) = happyShift action_74
action_58 (71) = happyShift action_75
action_58 (73) = happyShift action_76
action_58 (75) = happyShift action_77
action_58 (77) = happyShift action_78
action_58 (79) = happyShift action_79
action_58 (80) = happyShift action_80
action_58 (81) = happyShift action_81
action_58 (82) = happyShift action_82
action_58 (83) = happyShift action_83
action_58 (84) = happyShift action_84
action_58 (85) = happyShift action_85
action_58 (86) = happyShift action_86
action_58 (87) = happyShift action_87
action_58 (88) = happyShift action_88
action_58 _ = happyReduce_10

action_59 (65) = happyShift action_72
action_59 (67) = happyShift action_73
action_59 (69) = happyShift action_74
action_59 (71) = happyShift action_75
action_59 (73) = happyShift action_76
action_59 (75) = happyShift action_77
action_59 (77) = happyShift action_78
action_59 (79) = happyShift action_79
action_59 (80) = happyShift action_80
action_59 (81) = happyShift action_81
action_59 (82) = happyShift action_82
action_59 (83) = happyShift action_83
action_59 (84) = happyShift action_84
action_59 (85) = happyShift action_85
action_59 (86) = happyShift action_86
action_59 (87) = happyShift action_87
action_59 (88) = happyShift action_88
action_59 _ = happyReduce_9

action_60 (65) = happyShift action_72
action_60 (67) = happyShift action_73
action_60 (69) = happyShift action_74
action_60 (71) = happyShift action_75
action_60 (73) = happyShift action_76
action_60 (75) = happyShift action_77
action_60 (77) = happyShift action_78
action_60 (79) = happyShift action_79
action_60 (80) = happyShift action_80
action_60 (81) = happyShift action_81
action_60 (82) = happyShift action_82
action_60 (83) = happyShift action_83
action_60 (84) = happyShift action_84
action_60 (85) = happyShift action_85
action_60 (86) = happyShift action_86
action_60 (87) = happyShift action_87
action_60 (88) = happyShift action_88
action_60 _ = happyReduce_8

action_61 _ = happyReduce_33

action_62 (55) = happyShift action_91
action_62 (58) = happyShift action_92
action_62 (65) = happyShift action_72
action_62 (67) = happyShift action_73
action_62 (69) = happyShift action_74
action_62 (71) = happyShift action_75
action_62 (73) = happyShift action_76
action_62 (75) = happyShift action_77
action_62 (77) = happyShift action_78
action_62 (79) = happyShift action_79
action_62 (80) = happyShift action_80
action_62 (81) = happyShift action_81
action_62 (82) = happyShift action_82
action_62 (83) = happyShift action_83
action_62 (84) = happyShift action_84
action_62 (85) = happyShift action_85
action_62 (86) = happyShift action_86
action_62 (87) = happyShift action_87
action_62 (88) = happyShift action_88
action_62 _ = happyFail (happyExpListPerState 62)

action_63 (21) = happyShift action_46
action_63 (22) = happyShift action_47
action_63 (52) = happyShift action_19
action_63 (67) = happyShift action_48
action_63 (90) = happyShift action_49
action_63 (91) = happyShift action_50
action_63 (92) = happyShift action_51
action_63 (93) = happyShift action_22
action_63 (94) = happyShift action_52
action_63 (95) = happyShift action_53
action_63 (12) = happyGoto action_43
action_63 (13) = happyGoto action_90
action_63 (15) = happyGoto action_45
action_63 _ = happyFail (happyExpListPerState 63)

action_64 (53) = happyShift action_89
action_64 (65) = happyShift action_72
action_64 (67) = happyShift action_73
action_64 (69) = happyShift action_74
action_64 (71) = happyShift action_75
action_64 (73) = happyShift action_76
action_64 (75) = happyShift action_77
action_64 (77) = happyShift action_78
action_64 (79) = happyShift action_79
action_64 (80) = happyShift action_80
action_64 (81) = happyShift action_81
action_64 (82) = happyShift action_82
action_64 (83) = happyShift action_83
action_64 (84) = happyShift action_84
action_64 (85) = happyShift action_85
action_64 (86) = happyShift action_86
action_64 (87) = happyShift action_87
action_64 (88) = happyShift action_88
action_64 _ = happyFail (happyExpListPerState 64)

action_65 (53) = happyShift action_71
action_65 (65) = happyShift action_72
action_65 (67) = happyShift action_73
action_65 (69) = happyShift action_74
action_65 (71) = happyShift action_75
action_65 (73) = happyShift action_76
action_65 (75) = happyShift action_77
action_65 (77) = happyShift action_78
action_65 (79) = happyShift action_79
action_65 (80) = happyShift action_80
action_65 (81) = happyShift action_81
action_65 (82) = happyShift action_82
action_65 (83) = happyShift action_83
action_65 (84) = happyShift action_84
action_65 (85) = happyShift action_85
action_65 (86) = happyShift action_86
action_65 (87) = happyShift action_87
action_65 (88) = happyShift action_88
action_65 _ = happyFail (happyExpListPerState 65)

action_66 _ = happyReduce_35

action_67 (29) = happyShift action_68
action_67 (30) = happyShift action_69
action_67 (31) = happyShift action_70
action_67 _ = happyFail (happyExpListPerState 67)

action_68 _ = happyReduce_28

action_69 _ = happyReduce_29

action_70 _ = happyReduce_30

action_71 (56) = happyShift action_121
action_71 _ = happyFail (happyExpListPerState 71)

action_72 (21) = happyShift action_46
action_72 (22) = happyShift action_47
action_72 (52) = happyShift action_19
action_72 (67) = happyShift action_48
action_72 (90) = happyShift action_49
action_72 (91) = happyShift action_50
action_72 (92) = happyShift action_51
action_72 (93) = happyShift action_22
action_72 (94) = happyShift action_52
action_72 (95) = happyShift action_53
action_72 (12) = happyGoto action_43
action_72 (13) = happyGoto action_120
action_72 (15) = happyGoto action_45
action_72 _ = happyFail (happyExpListPerState 72)

action_73 (21) = happyShift action_46
action_73 (22) = happyShift action_47
action_73 (52) = happyShift action_19
action_73 (67) = happyShift action_48
action_73 (90) = happyShift action_49
action_73 (91) = happyShift action_50
action_73 (92) = happyShift action_51
action_73 (93) = happyShift action_22
action_73 (94) = happyShift action_52
action_73 (95) = happyShift action_53
action_73 (12) = happyGoto action_43
action_73 (13) = happyGoto action_119
action_73 (15) = happyGoto action_45
action_73 _ = happyFail (happyExpListPerState 73)

action_74 (21) = happyShift action_46
action_74 (22) = happyShift action_47
action_74 (52) = happyShift action_19
action_74 (67) = happyShift action_48
action_74 (90) = happyShift action_49
action_74 (91) = happyShift action_50
action_74 (92) = happyShift action_51
action_74 (93) = happyShift action_22
action_74 (94) = happyShift action_52
action_74 (95) = happyShift action_53
action_74 (12) = happyGoto action_43
action_74 (13) = happyGoto action_118
action_74 (15) = happyGoto action_45
action_74 _ = happyFail (happyExpListPerState 74)

action_75 (21) = happyShift action_46
action_75 (22) = happyShift action_47
action_75 (52) = happyShift action_19
action_75 (67) = happyShift action_48
action_75 (90) = happyShift action_49
action_75 (91) = happyShift action_50
action_75 (92) = happyShift action_51
action_75 (93) = happyShift action_22
action_75 (94) = happyShift action_52
action_75 (95) = happyShift action_53
action_75 (12) = happyGoto action_43
action_75 (13) = happyGoto action_117
action_75 (15) = happyGoto action_45
action_75 _ = happyFail (happyExpListPerState 75)

action_76 (21) = happyShift action_46
action_76 (22) = happyShift action_47
action_76 (52) = happyShift action_19
action_76 (67) = happyShift action_48
action_76 (90) = happyShift action_49
action_76 (91) = happyShift action_50
action_76 (92) = happyShift action_51
action_76 (93) = happyShift action_22
action_76 (94) = happyShift action_52
action_76 (95) = happyShift action_53
action_76 (12) = happyGoto action_43
action_76 (13) = happyGoto action_116
action_76 (15) = happyGoto action_45
action_76 _ = happyFail (happyExpListPerState 76)

action_77 (21) = happyShift action_46
action_77 (22) = happyShift action_47
action_77 (52) = happyShift action_19
action_77 (67) = happyShift action_48
action_77 (90) = happyShift action_49
action_77 (91) = happyShift action_50
action_77 (92) = happyShift action_51
action_77 (93) = happyShift action_22
action_77 (94) = happyShift action_52
action_77 (95) = happyShift action_53
action_77 (12) = happyGoto action_43
action_77 (13) = happyGoto action_115
action_77 (15) = happyGoto action_45
action_77 _ = happyFail (happyExpListPerState 77)

action_78 (21) = happyShift action_46
action_78 (22) = happyShift action_47
action_78 (52) = happyShift action_19
action_78 (67) = happyShift action_48
action_78 (90) = happyShift action_49
action_78 (91) = happyShift action_50
action_78 (92) = happyShift action_51
action_78 (93) = happyShift action_22
action_78 (94) = happyShift action_52
action_78 (95) = happyShift action_53
action_78 (12) = happyGoto action_43
action_78 (13) = happyGoto action_114
action_78 (15) = happyGoto action_45
action_78 _ = happyFail (happyExpListPerState 78)

action_79 (21) = happyShift action_46
action_79 (22) = happyShift action_47
action_79 (52) = happyShift action_19
action_79 (67) = happyShift action_48
action_79 (90) = happyShift action_49
action_79 (91) = happyShift action_50
action_79 (92) = happyShift action_51
action_79 (93) = happyShift action_22
action_79 (94) = happyShift action_52
action_79 (95) = happyShift action_53
action_79 (12) = happyGoto action_43
action_79 (13) = happyGoto action_113
action_79 (15) = happyGoto action_45
action_79 _ = happyFail (happyExpListPerState 79)

action_80 (21) = happyShift action_46
action_80 (22) = happyShift action_47
action_80 (52) = happyShift action_19
action_80 (67) = happyShift action_48
action_80 (90) = happyShift action_49
action_80 (91) = happyShift action_50
action_80 (92) = happyShift action_51
action_80 (93) = happyShift action_22
action_80 (94) = happyShift action_52
action_80 (95) = happyShift action_53
action_80 (12) = happyGoto action_43
action_80 (13) = happyGoto action_112
action_80 (15) = happyGoto action_45
action_80 _ = happyFail (happyExpListPerState 80)

action_81 (21) = happyShift action_46
action_81 (22) = happyShift action_47
action_81 (52) = happyShift action_19
action_81 (67) = happyShift action_48
action_81 (90) = happyShift action_49
action_81 (91) = happyShift action_50
action_81 (92) = happyShift action_51
action_81 (93) = happyShift action_22
action_81 (94) = happyShift action_52
action_81 (95) = happyShift action_53
action_81 (12) = happyGoto action_43
action_81 (13) = happyGoto action_111
action_81 (15) = happyGoto action_45
action_81 _ = happyFail (happyExpListPerState 81)

action_82 (21) = happyShift action_46
action_82 (22) = happyShift action_47
action_82 (52) = happyShift action_19
action_82 (67) = happyShift action_48
action_82 (90) = happyShift action_49
action_82 (91) = happyShift action_50
action_82 (92) = happyShift action_51
action_82 (93) = happyShift action_22
action_82 (94) = happyShift action_52
action_82 (95) = happyShift action_53
action_82 (12) = happyGoto action_43
action_82 (13) = happyGoto action_110
action_82 (15) = happyGoto action_45
action_82 _ = happyFail (happyExpListPerState 82)

action_83 (21) = happyShift action_46
action_83 (22) = happyShift action_47
action_83 (52) = happyShift action_19
action_83 (67) = happyShift action_48
action_83 (90) = happyShift action_49
action_83 (91) = happyShift action_50
action_83 (92) = happyShift action_51
action_83 (93) = happyShift action_22
action_83 (94) = happyShift action_52
action_83 (95) = happyShift action_53
action_83 (12) = happyGoto action_43
action_83 (13) = happyGoto action_109
action_83 (15) = happyGoto action_45
action_83 _ = happyFail (happyExpListPerState 83)

action_84 (21) = happyShift action_46
action_84 (22) = happyShift action_47
action_84 (52) = happyShift action_19
action_84 (67) = happyShift action_48
action_84 (90) = happyShift action_49
action_84 (91) = happyShift action_50
action_84 (92) = happyShift action_51
action_84 (93) = happyShift action_22
action_84 (94) = happyShift action_52
action_84 (95) = happyShift action_53
action_84 (12) = happyGoto action_43
action_84 (13) = happyGoto action_108
action_84 (15) = happyGoto action_45
action_84 _ = happyFail (happyExpListPerState 84)

action_85 (21) = happyShift action_46
action_85 (22) = happyShift action_47
action_85 (52) = happyShift action_19
action_85 (67) = happyShift action_48
action_85 (90) = happyShift action_49
action_85 (91) = happyShift action_50
action_85 (92) = happyShift action_51
action_85 (93) = happyShift action_22
action_85 (94) = happyShift action_52
action_85 (95) = happyShift action_53
action_85 (12) = happyGoto action_43
action_85 (13) = happyGoto action_107
action_85 (15) = happyGoto action_45
action_85 _ = happyFail (happyExpListPerState 85)

action_86 (21) = happyShift action_46
action_86 (22) = happyShift action_47
action_86 (52) = happyShift action_19
action_86 (67) = happyShift action_48
action_86 (90) = happyShift action_49
action_86 (91) = happyShift action_50
action_86 (92) = happyShift action_51
action_86 (93) = happyShift action_22
action_86 (94) = happyShift action_52
action_86 (95) = happyShift action_53
action_86 (12) = happyGoto action_43
action_86 (13) = happyGoto action_106
action_86 (15) = happyGoto action_45
action_86 _ = happyFail (happyExpListPerState 86)

action_87 (21) = happyShift action_46
action_87 (22) = happyShift action_47
action_87 (52) = happyShift action_19
action_87 (67) = happyShift action_48
action_87 (90) = happyShift action_49
action_87 (91) = happyShift action_50
action_87 (92) = happyShift action_51
action_87 (93) = happyShift action_22
action_87 (94) = happyShift action_52
action_87 (95) = happyShift action_53
action_87 (12) = happyGoto action_43
action_87 (13) = happyGoto action_105
action_87 (15) = happyGoto action_45
action_87 _ = happyFail (happyExpListPerState 87)

action_88 (21) = happyShift action_46
action_88 (22) = happyShift action_47
action_88 (52) = happyShift action_19
action_88 (67) = happyShift action_48
action_88 (90) = happyShift action_49
action_88 (91) = happyShift action_50
action_88 (92) = happyShift action_51
action_88 (93) = happyShift action_22
action_88 (94) = happyShift action_52
action_88 (95) = happyShift action_53
action_88 (12) = happyGoto action_43
action_88 (13) = happyGoto action_104
action_88 (15) = happyGoto action_45
action_88 _ = happyFail (happyExpListPerState 88)

action_89 (56) = happyShift action_103
action_89 _ = happyFail (happyExpListPerState 89)

action_90 (55) = happyShift action_102
action_90 (65) = happyShift action_72
action_90 (67) = happyShift action_73
action_90 (69) = happyShift action_74
action_90 (71) = happyShift action_75
action_90 (73) = happyShift action_76
action_90 (75) = happyShift action_77
action_90 (77) = happyShift action_78
action_90 (79) = happyShift action_79
action_90 (80) = happyShift action_80
action_90 (81) = happyShift action_81
action_90 (82) = happyShift action_82
action_90 (83) = happyShift action_83
action_90 (84) = happyShift action_84
action_90 (85) = happyShift action_85
action_90 (86) = happyShift action_86
action_90 (87) = happyShift action_87
action_90 (88) = happyShift action_88
action_90 _ = happyFail (happyExpListPerState 90)

action_91 (54) = happyFail []
action_91 (14) = happyGoto action_101
action_91 _ = happyReduce_63

action_92 (21) = happyShift action_46
action_92 (22) = happyShift action_47
action_92 (52) = happyShift action_19
action_92 (55) = happyShift action_100
action_92 (67) = happyShift action_48
action_92 (90) = happyShift action_49
action_92 (91) = happyShift action_50
action_92 (92) = happyShift action_51
action_92 (93) = happyShift action_22
action_92 (94) = happyShift action_52
action_92 (95) = happyShift action_53
action_92 (12) = happyGoto action_43
action_92 (13) = happyGoto action_99
action_92 (15) = happyGoto action_45
action_92 _ = happyFail (happyExpListPerState 92)

action_93 (65) = happyShift action_72
action_93 (67) = happyShift action_73
action_93 (69) = happyShift action_74
action_93 (71) = happyShift action_75
action_93 (73) = happyShift action_76
action_93 (75) = happyShift action_77
action_93 (77) = happyShift action_78
action_93 _ = happyReduce_60

action_94 _ = happyReduce_47

action_95 (21) = happyShift action_46
action_95 (22) = happyShift action_47
action_95 (52) = happyShift action_19
action_95 (53) = happyShift action_98
action_95 (67) = happyShift action_48
action_95 (90) = happyShift action_49
action_95 (91) = happyShift action_50
action_95 (92) = happyShift action_51
action_95 (93) = happyShift action_22
action_95 (94) = happyShift action_52
action_95 (95) = happyShift action_53
action_95 (12) = happyGoto action_43
action_95 (13) = happyGoto action_96
action_95 (15) = happyGoto action_45
action_95 (16) = happyGoto action_97
action_95 _ = happyFail (happyExpListPerState 95)

action_96 (60) = happyShift action_128
action_96 (65) = happyShift action_72
action_96 (67) = happyShift action_73
action_96 (69) = happyShift action_74
action_96 (71) = happyShift action_75
action_96 (73) = happyShift action_76
action_96 (75) = happyShift action_77
action_96 (77) = happyShift action_78
action_96 (79) = happyShift action_79
action_96 (80) = happyShift action_80
action_96 (81) = happyShift action_81
action_96 (82) = happyShift action_82
action_96 (83) = happyShift action_83
action_96 (84) = happyShift action_84
action_96 (85) = happyShift action_85
action_96 (86) = happyShift action_86
action_96 (87) = happyShift action_87
action_96 (88) = happyShift action_88
action_96 _ = happyReduce_74

action_97 (53) = happyShift action_127
action_97 _ = happyFail (happyExpListPerState 97)

action_98 _ = happyReduce_72

action_99 (55) = happyShift action_126
action_99 (65) = happyShift action_72
action_99 (67) = happyShift action_73
action_99 (69) = happyShift action_74
action_99 (71) = happyShift action_75
action_99 (73) = happyShift action_76
action_99 (75) = happyShift action_77
action_99 (77) = happyShift action_78
action_99 (79) = happyShift action_79
action_99 (80) = happyShift action_80
action_99 (81) = happyShift action_81
action_99 (82) = happyShift action_82
action_99 (83) = happyShift action_83
action_99 (84) = happyShift action_84
action_99 (85) = happyShift action_85
action_99 (86) = happyShift action_86
action_99 (87) = happyShift action_87
action_99 (88) = happyShift action_88
action_99 _ = happyFail (happyExpListPerState 99)

action_100 (54) = happyFail []
action_100 (14) = happyGoto action_125
action_100 _ = happyReduce_69

action_101 _ = happyReduce_64

action_102 (54) = happyFail []
action_102 (14) = happyGoto action_124
action_102 _ = happyReduce_67

action_103 (20) = happyShift action_13
action_103 (23) = happyShift action_14
action_103 (24) = happyShift action_15
action_103 (25) = happyShift action_16
action_103 (44) = happyShift action_17
action_103 (47) = happyShift action_18
action_103 (52) = happyShift action_19
action_103 (54) = happyShift action_20
action_103 (63) = happyShift action_21
action_103 (93) = happyShift action_22
action_103 (5) = happyGoto action_123
action_103 (6) = happyGoto action_6
action_103 (7) = happyGoto action_7
action_103 (9) = happyGoto action_8
action_103 (10) = happyGoto action_9
action_103 (11) = happyGoto action_10
action_103 (12) = happyGoto action_11
action_103 _ = happyFail (happyExpListPerState 103)

action_104 (65) = happyShift action_72
action_104 (67) = happyShift action_73
action_104 (69) = happyShift action_74
action_104 (71) = happyShift action_75
action_104 (73) = happyShift action_76
action_104 (75) = happyShift action_77
action_104 (77) = happyShift action_78
action_104 (79) = happyFail []
action_104 (80) = happyFail []
action_104 (81) = happyFail []
action_104 (82) = happyFail []
action_104 (83) = happyShift action_83
action_104 (84) = happyShift action_84
action_104 (85) = happyShift action_85
action_104 (86) = happyShift action_86
action_104 (87) = happyFail []
action_104 (88) = happyFail []
action_104 _ = happyReduce_49

action_105 (65) = happyShift action_72
action_105 (67) = happyShift action_73
action_105 (69) = happyShift action_74
action_105 (71) = happyShift action_75
action_105 (73) = happyShift action_76
action_105 (75) = happyShift action_77
action_105 (77) = happyShift action_78
action_105 (79) = happyFail []
action_105 (80) = happyFail []
action_105 (81) = happyFail []
action_105 (82) = happyFail []
action_105 (83) = happyShift action_83
action_105 (84) = happyShift action_84
action_105 (85) = happyShift action_85
action_105 (86) = happyShift action_86
action_105 (87) = happyFail []
action_105 (88) = happyFail []
action_105 _ = happyReduce_48

action_106 (65) = happyShift action_72
action_106 (67) = happyShift action_73
action_106 (69) = happyShift action_74
action_106 (71) = happyShift action_75
action_106 (73) = happyShift action_76
action_106 (75) = happyShift action_77
action_106 (77) = happyShift action_78
action_106 _ = happyReduce_59

action_107 (65) = happyShift action_72
action_107 (67) = happyShift action_73
action_107 (69) = happyShift action_74
action_107 (71) = happyShift action_75
action_107 (73) = happyShift action_76
action_107 (75) = happyShift action_77
action_107 (77) = happyShift action_78
action_107 _ = happyReduce_58

action_108 (65) = happyShift action_72
action_108 (67) = happyShift action_73
action_108 (69) = happyShift action_74
action_108 (71) = happyShift action_75
action_108 (73) = happyShift action_76
action_108 (75) = happyShift action_77
action_108 (77) = happyShift action_78
action_108 _ = happyReduce_57

action_109 (65) = happyShift action_72
action_109 (67) = happyShift action_73
action_109 (69) = happyShift action_74
action_109 (71) = happyShift action_75
action_109 (73) = happyShift action_76
action_109 (75) = happyShift action_77
action_109 (77) = happyShift action_78
action_109 _ = happyReduce_56

action_110 (65) = happyShift action_72
action_110 (67) = happyShift action_73
action_110 (69) = happyShift action_74
action_110 (71) = happyShift action_75
action_110 (73) = happyShift action_76
action_110 (75) = happyShift action_77
action_110 (77) = happyShift action_78
action_110 (79) = happyFail []
action_110 (80) = happyFail []
action_110 (81) = happyFail []
action_110 (82) = happyFail []
action_110 (83) = happyShift action_83
action_110 (84) = happyShift action_84
action_110 (85) = happyShift action_85
action_110 (86) = happyShift action_86
action_110 (87) = happyFail []
action_110 (88) = happyFail []
action_110 _ = happyReduce_52

action_111 (65) = happyShift action_72
action_111 (67) = happyShift action_73
action_111 (69) = happyShift action_74
action_111 (71) = happyShift action_75
action_111 (73) = happyShift action_76
action_111 (75) = happyShift action_77
action_111 (77) = happyShift action_78
action_111 (79) = happyFail []
action_111 (80) = happyFail []
action_111 (81) = happyFail []
action_111 (82) = happyFail []
action_111 (83) = happyShift action_83
action_111 (84) = happyShift action_84
action_111 (85) = happyShift action_85
action_111 (86) = happyShift action_86
action_111 (87) = happyFail []
action_111 (88) = happyFail []
action_111 _ = happyReduce_53

action_112 (65) = happyShift action_72
action_112 (67) = happyShift action_73
action_112 (69) = happyShift action_74
action_112 (71) = happyShift action_75
action_112 (73) = happyShift action_76
action_112 (75) = happyShift action_77
action_112 (77) = happyShift action_78
action_112 (79) = happyFail []
action_112 (80) = happyFail []
action_112 (81) = happyFail []
action_112 (82) = happyFail []
action_112 (83) = happyShift action_83
action_112 (84) = happyShift action_84
action_112 (85) = happyShift action_85
action_112 (86) = happyShift action_86
action_112 (87) = happyFail []
action_112 (88) = happyFail []
action_112 _ = happyReduce_50

action_113 (65) = happyShift action_72
action_113 (67) = happyShift action_73
action_113 (69) = happyShift action_74
action_113 (71) = happyShift action_75
action_113 (73) = happyShift action_76
action_113 (75) = happyShift action_77
action_113 (77) = happyShift action_78
action_113 (79) = happyFail []
action_113 (80) = happyFail []
action_113 (81) = happyFail []
action_113 (82) = happyFail []
action_113 (83) = happyShift action_83
action_113 (84) = happyShift action_84
action_113 (85) = happyShift action_85
action_113 (86) = happyShift action_86
action_113 (87) = happyFail []
action_113 (88) = happyFail []
action_113 _ = happyReduce_51

action_114 (71) = happyShift action_75
action_114 _ = happyReduce_45

action_115 (71) = happyShift action_75
action_115 _ = happyReduce_43

action_116 (71) = happyShift action_75
action_116 _ = happyReduce_44

action_117 (71) = happyFail []
action_117 _ = happyReduce_46

action_118 (71) = happyShift action_75
action_118 _ = happyReduce_42

action_119 (69) = happyShift action_74
action_119 (71) = happyShift action_75
action_119 (73) = happyShift action_76
action_119 (75) = happyShift action_77
action_119 (77) = happyShift action_78
action_119 _ = happyReduce_41

action_120 (69) = happyShift action_74
action_120 (71) = happyShift action_75
action_120 (73) = happyShift action_76
action_120 (75) = happyShift action_77
action_120 (77) = happyShift action_78
action_120 _ = happyReduce_40

action_121 (20) = happyShift action_13
action_121 (23) = happyShift action_14
action_121 (24) = happyShift action_15
action_121 (25) = happyShift action_16
action_121 (44) = happyShift action_17
action_121 (47) = happyShift action_18
action_121 (52) = happyShift action_19
action_121 (54) = happyShift action_20
action_121 (63) = happyShift action_21
action_121 (93) = happyShift action_22
action_121 (5) = happyGoto action_122
action_121 (6) = happyGoto action_6
action_121 (7) = happyGoto action_7
action_121 (9) = happyGoto action_8
action_121 (10) = happyGoto action_9
action_121 (11) = happyGoto action_10
action_121 (12) = happyGoto action_11
action_121 _ = happyFail (happyExpListPerState 121)

action_122 (57) = happyShift action_132
action_122 _ = happyFail (happyExpListPerState 122)

action_123 (57) = happyShift action_131
action_123 _ = happyFail (happyExpListPerState 123)

action_124 _ = happyReduce_68

action_125 _ = happyReduce_70

action_126 (54) = happyFail []
action_126 (14) = happyGoto action_130
action_126 _ = happyReduce_65

action_127 _ = happyReduce_71

action_128 (21) = happyShift action_46
action_128 (22) = happyShift action_47
action_128 (52) = happyShift action_19
action_128 (67) = happyShift action_48
action_128 (90) = happyShift action_49
action_128 (91) = happyShift action_50
action_128 (92) = happyShift action_51
action_128 (93) = happyShift action_22
action_128 (94) = happyShift action_52
action_128 (95) = happyShift action_53
action_128 (12) = happyGoto action_43
action_128 (13) = happyGoto action_96
action_128 (15) = happyGoto action_45
action_128 (16) = happyGoto action_129
action_128 _ = happyFail (happyExpListPerState 128)

action_129 _ = happyReduce_73

action_130 _ = happyReduce_66

action_131 (45) = happyShift action_134
action_131 (46) = happyShift action_135
action_131 (8) = happyGoto action_133
action_131 _ = happyReduce_16

action_132 _ = happyReduce_17

action_133 _ = happyReduce_18

action_134 (52) = happyShift action_137
action_134 _ = happyFail (happyExpListPerState 134)

action_135 (56) = happyShift action_136
action_135 _ = happyFail (happyExpListPerState 135)

action_136 (20) = happyShift action_13
action_136 (23) = happyShift action_14
action_136 (24) = happyShift action_15
action_136 (25) = happyShift action_16
action_136 (44) = happyShift action_17
action_136 (47) = happyShift action_18
action_136 (52) = happyShift action_19
action_136 (54) = happyShift action_20
action_136 (63) = happyShift action_21
action_136 (93) = happyShift action_22
action_136 (5) = happyGoto action_139
action_136 (6) = happyGoto action_6
action_136 (7) = happyGoto action_7
action_136 (9) = happyGoto action_8
action_136 (10) = happyGoto action_9
action_136 (11) = happyGoto action_10
action_136 (12) = happyGoto action_11
action_136 _ = happyFail (happyExpListPerState 136)

action_137 (21) = happyShift action_46
action_137 (22) = happyShift action_47
action_137 (52) = happyShift action_19
action_137 (67) = happyShift action_48
action_137 (90) = happyShift action_49
action_137 (91) = happyShift action_50
action_137 (92) = happyShift action_51
action_137 (93) = happyShift action_22
action_137 (94) = happyShift action_52
action_137 (95) = happyShift action_53
action_137 (12) = happyGoto action_43
action_137 (13) = happyGoto action_138
action_137 (15) = happyGoto action_45
action_137 _ = happyFail (happyExpListPerState 137)

action_138 (53) = happyShift action_141
action_138 (65) = happyShift action_72
action_138 (67) = happyShift action_73
action_138 (69) = happyShift action_74
action_138 (71) = happyShift action_75
action_138 (73) = happyShift action_76
action_138 (75) = happyShift action_77
action_138 (77) = happyShift action_78
action_138 (79) = happyShift action_79
action_138 (80) = happyShift action_80
action_138 (81) = happyShift action_81
action_138 (82) = happyShift action_82
action_138 (83) = happyShift action_83
action_138 (84) = happyShift action_84
action_138 (85) = happyShift action_85
action_138 (86) = happyShift action_86
action_138 (87) = happyShift action_87
action_138 (88) = happyShift action_88
action_138 _ = happyFail (happyExpListPerState 138)

action_139 (57) = happyShift action_140
action_139 _ = happyFail (happyExpListPerState 139)

action_140 _ = happyReduce_20

action_141 (56) = happyShift action_142
action_141 _ = happyFail (happyExpListPerState 141)

action_142 (20) = happyShift action_13
action_142 (23) = happyShift action_14
action_142 (24) = happyShift action_15
action_142 (25) = happyShift action_16
action_142 (44) = happyShift action_17
action_142 (47) = happyShift action_18
action_142 (52) = happyShift action_19
action_142 (54) = happyShift action_20
action_142 (63) = happyShift action_21
action_142 (93) = happyShift action_22
action_142 (5) = happyGoto action_143
action_142 (6) = happyGoto action_6
action_142 (7) = happyGoto action_7
action_142 (9) = happyGoto action_8
action_142 (10) = happyGoto action_9
action_142 (11) = happyGoto action_10
action_142 (12) = happyGoto action_11
action_142 _ = happyFail (happyExpListPerState 142)

action_143 (57) = happyShift action_144
action_143 _ = happyFail (happyExpListPerState 143)

action_144 (45) = happyShift action_134
action_144 (46) = happyShift action_135
action_144 (8) = happyGoto action_145
action_144 _ = happyReduce_19

action_145 _ = happyReduce_21

happyReduce_1 = happySpecReduce_2  4 happyReduction_1
happyReduction_1 _
	_
	 =  HappyAbsSyn4
		 (Root []
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
		 ([happy_var_1]
	)
happyReduction_3 _  = notHappyAtAll 

happyReduce_4 = happySpecReduce_2  5 happyReduction_4
happyReduction_4 _
	(HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn5
		 ([happy_var_1]
	)
happyReduction_4 _ _  = notHappyAtAll 

happyReduce_5 = happySpecReduce_3  5 happyReduction_5
happyReduction_5 (HappyAbsSyn5  happy_var_3)
	_
	(HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn5
		 (happy_var_1 : happy_var_3
	)
happyReduction_5 _ _ _  = notHappyAtAll 

happyReduce_6 = happySpecReduce_1  6 happyReduction_6
happyReduction_6 (HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn6
		 (happy_var_1
	)
happyReduction_6 _  = notHappyAtAll 

happyReduce_7 = happySpecReduce_3  6 happyReduction_7
happyReduction_7 (HappyAbsSyn13  happy_var_3)
	_
	(HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn6
		 (Asig happy_var_1 happy_var_3
	)
happyReduction_7 _ _ _  = notHappyAtAll 

happyReduce_8 = happySpecReduce_3  6 happyReduction_8
happyReduction_8 (HappyAbsSyn13  happy_var_3)
	_
	(HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn6
		 (Asig happy_var_1 (Sum (Lval happy_var_1) happy_var_3)
	)
happyReduction_8 _ _ _  = notHappyAtAll 

happyReduce_9 = happySpecReduce_3  6 happyReduction_9
happyReduction_9 (HappyAbsSyn13  happy_var_3)
	_
	(HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn6
		 (Asig happy_var_1 (Sub (Lval happy_var_1) happy_var_3)
	)
happyReduction_9 _ _ _  = notHappyAtAll 

happyReduce_10 = happySpecReduce_3  6 happyReduction_10
happyReduction_10 (HappyAbsSyn13  happy_var_3)
	_
	(HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn6
		 (Asig happy_var_1 (Mul (Lval happy_var_1) happy_var_3)
	)
happyReduction_10 _ _ _  = notHappyAtAll 

happyReduce_11 = happySpecReduce_3  6 happyReduction_11
happyReduction_11 (HappyAbsSyn13  happy_var_3)
	_
	(HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn6
		 (Asig happy_var_1 (Div (Lval happy_var_1) happy_var_3)
	)
happyReduction_11 _ _ _  = notHappyAtAll 

happyReduce_12 = happySpecReduce_3  6 happyReduction_12
happyReduction_12 (HappyAbsSyn13  happy_var_3)
	_
	(HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn6
		 (Asig happy_var_1 (DivE (Lval happy_var_1) happy_var_3)
	)
happyReduction_12 _ _ _  = notHappyAtAll 

happyReduce_13 = happySpecReduce_3  6 happyReduction_13
happyReduction_13 (HappyAbsSyn13  happy_var_3)
	_
	(HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn6
		 (Asig happy_var_1 (Mod (Lval happy_var_1) happy_var_3)
	)
happyReduction_13 _ _ _  = notHappyAtAll 

happyReduce_14 = happySpecReduce_3  6 happyReduction_14
happyReduction_14 (HappyAbsSyn13  happy_var_3)
	_
	(HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn6
		 (Asig happy_var_1 (Pow (Lval happy_var_1) happy_var_3)
	)
happyReduction_14 _ _ _  = notHappyAtAll 

happyReduce_15 = happySpecReduce_1  6 happyReduction_15
happyReduction_15 (HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn6
		 (happy_var_1
	)
happyReduction_15 _  = notHappyAtAll 

happyReduce_16 = happyReduce 7 7 happyReduction_16
happyReduction_16 (_ `HappyStk`
	(HappyAbsSyn5  happy_var_6) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn13  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn7
		 (If [(happy_var_3, happy_var_6)]
	) `HappyStk` happyRest

happyReduce_17 = happyReduce 7 7 happyReduction_17
happyReduction_17 (_ `HappyStk`
	(HappyAbsSyn5  happy_var_6) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn13  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn7
		 (If [(Not happy_var_3, happy_var_6)]
	) `HappyStk` happyRest

happyReduce_18 = happyReduce 8 7 happyReduction_18
happyReduction_18 ((HappyAbsSyn8  happy_var_8) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn5  happy_var_6) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn13  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn7
		 (If ((happy_var_3, happy_var_6) : happy_var_8)
	) `HappyStk` happyRest

happyReduce_19 = happyReduce 7 8 happyReduction_19
happyReduction_19 (_ `HappyStk`
	(HappyAbsSyn5  happy_var_6) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn13  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn8
		 ([(happy_var_3, happy_var_6)]
	) `HappyStk` happyRest

happyReduce_20 = happyReduce 4 8 happyReduction_20
happyReduction_20 (_ `HappyStk`
	(HappyAbsSyn5  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn8
		 ([(Full, happy_var_3)]
	) `HappyStk` happyRest

happyReduce_21 = happyReduce 8 8 happyReduction_21
happyReduction_21 ((HappyAbsSyn8  happy_var_8) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn5  happy_var_6) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn13  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn8
		 ((happy_var_3, happy_var_6) : happy_var_8
	) `HappyStk` happyRest

happyReduce_22 = happySpecReduce_2  9 happyReduction_22
happyReduction_22 (HappyTerminal (TkId happy_var_2))
	(HappyAbsSyn10  happy_var_1)
	 =  HappyAbsSyn9
		 (Declar happy_var_1 (fst happy_var_2)
	)
happyReduction_22 _ _  = notHappyAtAll 

happyReduce_23 = happySpecReduce_1  10 happyReduction_23
happyReduction_23 _
	 =  HappyAbsSyn10
		 (Planet
	)

happyReduce_24 = happySpecReduce_1  10 happyReduction_24
happyReduction_24 _
	 =  HappyAbsSyn10
		 (Cloud
	)

happyReduce_25 = happySpecReduce_1  10 happyReduction_25
happyReduction_25 _
	 =  HappyAbsSyn10
		 (Star
	)

happyReduce_26 = happySpecReduce_1  10 happyReduction_26
happyReduction_26 _
	 =  HappyAbsSyn10
		 (Moon
	)

happyReduce_27 = happySpecReduce_1  10 happyReduction_27
happyReduction_27 (HappyAbsSyn11  happy_var_1)
	 =  HappyAbsSyn10
		 (happy_var_1
	)
happyReduction_27 _  = notHappyAtAll 

happyReduce_28 = happyReduce 4 11 happyReduction_28
happyReduction_28 (_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn10  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn11
		 (Cluster happy_var_2
	) `HappyStk` happyRest

happyReduce_29 = happyReduce 4 11 happyReduction_29
happyReduction_29 (_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn10  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn11
		 (Quasar happy_var_2
	) `HappyStk` happyRest

happyReduce_30 = happyReduce 4 11 happyReduction_30
happyReduction_30 (_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn10  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn11
		 (Nebula happy_var_2
	) `HappyStk` happyRest

happyReduce_31 = happySpecReduce_2  11 happyReduction_31
happyReduction_31 (HappyAbsSyn10  happy_var_2)
	_
	 =  HappyAbsSyn11
		 (Pointer happy_var_2
	)
happyReduction_31 _ _  = notHappyAtAll 

happyReduce_32 = happySpecReduce_1  12 happyReduction_32
happyReduction_32 (HappyTerminal (TkId happy_var_1))
	 =  HappyAbsSyn12
		 (Var (fst happy_var_1)
	)
happyReduction_32 _  = notHappyAtAll 

happyReduce_33 = happySpecReduce_3  12 happyReduction_33
happyReduction_33 (HappyTerminal (TkId happy_var_3))
	_
	(HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn12
		 (Attr happy_var_1 (fst happy_var_3)
	)
happyReduction_33 _ _ _  = notHappyAtAll 

happyReduce_34 = happySpecReduce_2  12 happyReduction_34
happyReduction_34 (HappyAbsSyn14  happy_var_2)
	(HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn12
		 (Access happy_var_1 happy_var_2
	)
happyReduction_34 _ _  = notHappyAtAll 

happyReduce_35 = happySpecReduce_3  12 happyReduction_35
happyReduction_35 _
	(HappyAbsSyn12  happy_var_2)
	_
	 =  HappyAbsSyn12
		 (happy_var_2
	)
happyReduction_35 _ _ _  = notHappyAtAll 

happyReduce_36 = happySpecReduce_1  13 happyReduction_36
happyReduction_36 (HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn13
		 (happy_var_1
	)
happyReduction_36 _  = notHappyAtAll 

happyReduce_37 = happySpecReduce_1  13 happyReduction_37
happyReduction_37 (HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn13
		 (Lval happy_var_1
	)
happyReduction_37 _  = notHappyAtAll 

happyReduce_38 = happySpecReduce_1  13 happyReduction_38
happyReduction_38 (HappyTerminal (TkInt happy_var_1))
	 =  HappyAbsSyn13
		 (IntLit (fst happy_var_1)
	)
happyReduction_38 _  = notHappyAtAll 

happyReduce_39 = happySpecReduce_1  13 happyReduction_39
happyReduction_39 (HappyTerminal (TkFloat happy_var_1))
	 =  HappyAbsSyn13
		 (FloLit (fst happy_var_1)
	)
happyReduction_39 _  = notHappyAtAll 

happyReduce_40 = happySpecReduce_3  13 happyReduction_40
happyReduction_40 (HappyAbsSyn13  happy_var_3)
	_
	(HappyAbsSyn13  happy_var_1)
	 =  HappyAbsSyn13
		 (Sum happy_var_1 happy_var_3
	)
happyReduction_40 _ _ _  = notHappyAtAll 

happyReduce_41 = happySpecReduce_3  13 happyReduction_41
happyReduction_41 (HappyAbsSyn13  happy_var_3)
	_
	(HappyAbsSyn13  happy_var_1)
	 =  HappyAbsSyn13
		 (Sub happy_var_1 happy_var_3
	)
happyReduction_41 _ _ _  = notHappyAtAll 

happyReduce_42 = happySpecReduce_3  13 happyReduction_42
happyReduction_42 (HappyAbsSyn13  happy_var_3)
	_
	(HappyAbsSyn13  happy_var_1)
	 =  HappyAbsSyn13
		 (Mul happy_var_1 happy_var_3
	)
happyReduction_42 _ _ _  = notHappyAtAll 

happyReduce_43 = happySpecReduce_3  13 happyReduction_43
happyReduction_43 (HappyAbsSyn13  happy_var_3)
	_
	(HappyAbsSyn13  happy_var_1)
	 =  HappyAbsSyn13
		 (Div happy_var_1 happy_var_3
	)
happyReduction_43 _ _ _  = notHappyAtAll 

happyReduce_44 = happySpecReduce_3  13 happyReduction_44
happyReduction_44 (HappyAbsSyn13  happy_var_3)
	_
	(HappyAbsSyn13  happy_var_1)
	 =  HappyAbsSyn13
		 (DivE happy_var_1 happy_var_3
	)
happyReduction_44 _ _ _  = notHappyAtAll 

happyReduce_45 = happySpecReduce_3  13 happyReduction_45
happyReduction_45 (HappyAbsSyn13  happy_var_3)
	_
	(HappyAbsSyn13  happy_var_1)
	 =  HappyAbsSyn13
		 (Mod happy_var_1 happy_var_3
	)
happyReduction_45 _ _ _  = notHappyAtAll 

happyReduce_46 = happySpecReduce_3  13 happyReduction_46
happyReduction_46 (HappyAbsSyn13  happy_var_3)
	_
	(HappyAbsSyn13  happy_var_1)
	 =  HappyAbsSyn13
		 (Pow happy_var_1 happy_var_3
	)
happyReduction_46 _ _ _  = notHappyAtAll 

happyReduce_47 = happySpecReduce_2  13 happyReduction_47
happyReduction_47 (HappyAbsSyn13  happy_var_2)
	_
	 =  HappyAbsSyn13
		 (Neg happy_var_2
	)
happyReduction_47 _ _  = notHappyAtAll 

happyReduce_48 = happySpecReduce_3  13 happyReduction_48
happyReduction_48 (HappyAbsSyn13  happy_var_3)
	_
	(HappyAbsSyn13  happy_var_1)
	 =  HappyAbsSyn13
		 (Eq happy_var_1 happy_var_3
	)
happyReduction_48 _ _ _  = notHappyAtAll 

happyReduce_49 = happySpecReduce_3  13 happyReduction_49
happyReduction_49 (HappyAbsSyn13  happy_var_3)
	_
	(HappyAbsSyn13  happy_var_1)
	 =  HappyAbsSyn13
		 (Neq happy_var_1 happy_var_3
	)
happyReduction_49 _ _ _  = notHappyAtAll 

happyReduce_50 = happySpecReduce_3  13 happyReduction_50
happyReduction_50 (HappyAbsSyn13  happy_var_3)
	_
	(HappyAbsSyn13  happy_var_1)
	 =  HappyAbsSyn13
		 (Mayor happy_var_1 happy_var_3
	)
happyReduction_50 _ _ _  = notHappyAtAll 

happyReduce_51 = happySpecReduce_3  13 happyReduction_51
happyReduction_51 (HappyAbsSyn13  happy_var_3)
	_
	(HappyAbsSyn13  happy_var_1)
	 =  HappyAbsSyn13
		 (MayorI happy_var_1 happy_var_3
	)
happyReduction_51 _ _ _  = notHappyAtAll 

happyReduce_52 = happySpecReduce_3  13 happyReduction_52
happyReduction_52 (HappyAbsSyn13  happy_var_3)
	_
	(HappyAbsSyn13  happy_var_1)
	 =  HappyAbsSyn13
		 (Menor happy_var_1 happy_var_3
	)
happyReduction_52 _ _ _  = notHappyAtAll 

happyReduce_53 = happySpecReduce_3  13 happyReduction_53
happyReduction_53 (HappyAbsSyn13  happy_var_3)
	_
	(HappyAbsSyn13  happy_var_1)
	 =  HappyAbsSyn13
		 (MenorI happy_var_1 happy_var_3
	)
happyReduction_53 _ _ _  = notHappyAtAll 

happyReduce_54 = happySpecReduce_1  13 happyReduction_54
happyReduction_54 _
	 =  HappyAbsSyn13
		 (New
	)

happyReduce_55 = happySpecReduce_1  13 happyReduction_55
happyReduction_55 _
	 =  HappyAbsSyn13
		 (Full
	)

happyReduce_56 = happySpecReduce_3  13 happyReduction_56
happyReduction_56 (HappyAbsSyn13  happy_var_3)
	_
	(HappyAbsSyn13  happy_var_1)
	 =  HappyAbsSyn13
		 (And happy_var_1 happy_var_3
	)
happyReduction_56 _ _ _  = notHappyAtAll 

happyReduce_57 = happySpecReduce_3  13 happyReduction_57
happyReduction_57 (HappyAbsSyn13  happy_var_3)
	_
	(HappyAbsSyn13  happy_var_1)
	 =  HappyAbsSyn13
		 (Bitand happy_var_1 happy_var_3
	)
happyReduction_57 _ _ _  = notHappyAtAll 

happyReduce_58 = happySpecReduce_3  13 happyReduction_58
happyReduction_58 (HappyAbsSyn13  happy_var_3)
	_
	(HappyAbsSyn13  happy_var_1)
	 =  HappyAbsSyn13
		 (Or happy_var_1 happy_var_3
	)
happyReduction_58 _ _ _  = notHappyAtAll 

happyReduce_59 = happySpecReduce_3  13 happyReduction_59
happyReduction_59 (HappyAbsSyn13  happy_var_3)
	_
	(HappyAbsSyn13  happy_var_1)
	 =  HappyAbsSyn13
		 (Bitor happy_var_1 happy_var_3
	)
happyReduction_59 _ _ _  = notHappyAtAll 

happyReduce_60 = happySpecReduce_2  13 happyReduction_60
happyReduction_60 (HappyAbsSyn13  happy_var_2)
	_
	 =  HappyAbsSyn13
		 (Not happy_var_2
	)
happyReduction_60 _ _  = notHappyAtAll 

happyReduce_61 = happySpecReduce_1  13 happyReduction_61
happyReduction_61 (HappyTerminal (TkString happy_var_1))
	 =  HappyAbsSyn13
		 (StrLit (fst happy_var_1)
	)
happyReduction_61 _  = notHappyAtAll 

happyReduce_62 = happySpecReduce_1  13 happyReduction_62
happyReduction_62 (HappyTerminal (TkChar happy_var_1))
	 =  HappyAbsSyn13
		 (CharLit (fst happy_var_1)
	)
happyReduction_62 _  = notHappyAtAll 

happyReduce_63 = happySpecReduce_3  14 happyReduction_63
happyReduction_63 _
	(HappyAbsSyn13  happy_var_2)
	_
	 =  HappyAbsSyn14
		 (Index happy_var_2
	)
happyReduction_63 _ _ _  = notHappyAtAll 

happyReduce_64 = happyReduce 4 14 happyReduction_64
happyReduction_64 ((HappyAbsSyn14  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn13  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn14
		 (ManyAc (Index happy_var_2) happy_var_4
	) `HappyStk` happyRest

happyReduce_65 = happyReduce 5 14 happyReduction_65
happyReduction_65 (_ `HappyStk`
	(HappyAbsSyn13  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn13  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn14
		 (Interval happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_66 = happyReduce 6 14 happyReduction_66
happyReduction_66 ((HappyAbsSyn14  happy_var_6) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn13  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn13  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn14
		 (ManyAc (Interval happy_var_2 happy_var_4) happy_var_6
	) `HappyStk` happyRest

happyReduce_67 = happyReduce 4 14 happyReduction_67
happyReduction_67 (_ `HappyStk`
	(HappyAbsSyn13  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn14
		 (Interval (IntLit 0) happy_var_3
	) `HappyStk` happyRest

happyReduce_68 = happyReduce 5 14 happyReduction_68
happyReduction_68 ((HappyAbsSyn14  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn13  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn14
		 (ManyAc (Interval (IntLit 0) happy_var_3) happy_var_5
	) `HappyStk` happyRest

happyReduce_69 = happyReduce 4 14 happyReduction_69
happyReduction_69 (_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn13  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn14
		 (Begin happy_var_2
	) `HappyStk` happyRest

happyReduce_70 = happyReduce 5 14 happyReduction_70
happyReduction_70 ((HappyAbsSyn14  happy_var_5) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn13  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn14
		 (ManyAc (Begin happy_var_2) happy_var_5
	) `HappyStk` happyRest

happyReduce_71 = happyReduce 4 15 happyReduction_71
happyReduction_71 (_ `HappyStk`
	(HappyAbsSyn16  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn12  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn15
		 (Funcall happy_var_1 happy_var_3
	) `HappyStk` happyRest

happyReduce_72 = happySpecReduce_3  15 happyReduction_72
happyReduction_72 _
	_
	(HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn15
		 (Funcall happy_var_1 []
	)
happyReduction_72 _ _ _  = notHappyAtAll 

happyReduce_73 = happySpecReduce_3  16 happyReduction_73
happyReduction_73 (HappyAbsSyn16  happy_var_3)
	_
	(HappyAbsSyn13  happy_var_1)
	 =  HappyAbsSyn16
		 (happy_var_1 : happy_var_3
	)
happyReduction_73 _ _ _  = notHappyAtAll 

happyReduce_74 = happySpecReduce_1  16 happyReduction_74
happyReduction_74 (HappyAbsSyn13  happy_var_1)
	 =  HappyAbsSyn16
		 ([happy_var_1]
	)
happyReduction_74 _  = notHappyAtAll 

happyReduce_75 = happyReduce 4 17 happyReduction_75
happyReduction_75 ((HappyAbsSyn17  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn13  happy_var_2) `HappyStk`
	(HappyAbsSyn10  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn17
		 ((happy_var_1, happy_var_2, False) : happy_var_4
	) `HappyStk` happyRest

happyReduce_76 = happySpecReduce_2  17 happyReduction_76
happyReduction_76 (HappyAbsSyn13  happy_var_2)
	(HappyAbsSyn10  happy_var_1)
	 =  HappyAbsSyn17
		 ([(happy_var_1, happy_var_2, False)]
	)
happyReduction_76 _ _  = notHappyAtAll 

happyReduce_77 = happyReduce 5 17 happyReduction_77
happyReduction_77 ((HappyAbsSyn17  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn13  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn10  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn17
		 ((happy_var_1, happy_var_3, True) : happy_var_5
	) `HappyStk` happyRest

happyReduce_78 = happySpecReduce_3  17 happyReduction_78
happyReduction_78 _
	_
	(HappyAbsSyn10  happy_var_1)
	 =  HappyAbsSyn17
		 ([(happy_var_1, True)]
	)
happyReduction_78 _ _ _  = notHappyAtAll 

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
      = Root [Instr] 
      deriving Show

data Instr 
      = Perro String
      | Declar Type String
      | Asig LValue Exp
      | If [(Exp, [Instr])]
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

data Slice
      = ManyAc Slice Slice
      | Key String
      | Index Exp
      | Interval Exp Exp
      | Begin Exp
      deriving Show

data Exp
      = Funcall LValue [Exp]
      | Lval LValue
      | LBool Exp
      -- Numericas
      | IntLit Int
      | FloLit Float
      | Sum Exp Exp
      | Sub Exp Exp
      | Mul Exp Exp
      | Pow Exp Exp
      | Div Exp Exp
      | DivE Exp Exp
      | Mod Exp Exp
      | Neg Exp
      -- Comparaciones
      | Eq Exp Exp
      | Neq Exp Exp
      | Mayor Exp Exp
      | MayorI Exp Exp
      | Menor Exp Exp
      | MenorI Exp Exp
      -- Bool
      | New
      | Full
      | And Exp Exp
      | Bitand Exp Exp
      | Or Exp Exp
      | Bitor Exp Exp
      | Not Exp
      -- Otros
      | StrLit String
      | CharLit Char
      deriving Show

gato f = do
  s <- readFile(f)
  return( midnight $ filter (not.isError) (alexScanTokens s) )


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
