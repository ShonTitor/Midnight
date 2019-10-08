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

data HappyAbsSyn t4 t5 t6 t7 t8 t9 t10 t11 t12 t13 t14
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

happyExpList :: Happy_Data_Array.Array Int Int
happyExpList = Happy_Data_Array.listArray (0,486) ([16384,0,0,0,0,0,2048,0,0,0,0,0,512,0,0,0,0,0,0,0,0,0,0,0,920,0,32848,0,8192,0,1,0,0,0,0,0,0,0,128,0,0,0,0,0,0,0,0,0,0,0,0,0,2,0,0,0,0,0,0,0,0,16912,2389,128,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,512,8192,7,32768,256,0,0,58368,0,4096,32,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16,0,0,0,0,32768,33,0,0,0,0,0,0,0,0,0,0,16640,128,16384,2,0,0,0,0,16384,0,0,0,4,2,2304,0,0,32768,16384,0,288,0,0,4096,2048,0,36,0,0,512,256,32768,4,0,0,64,32,36864,0,0,0,8,4,4608,0,0,0,32769,0,576,0,0,8192,4096,0,72,0,0,0,0,0,0,7296,0,640,4,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,16384,33,0,0,0,0,0,21760,65493,0,0,0,0,0,0,0,0,0,32,16,18432,0,0,0,4,2,2304,0,0,0,20480,64853,15,0,0,0,43520,65450,1,0,0,0,21824,16373,0,0,0,0,43688,2046,0,0,0,0,54613,255,0,0,0,40960,64170,31,0,0,0,21504,65365,3,0,0,0,0,0,0,0,0,9216,21840,4093,0,0,0,16,8,9216,0,0,0,0,0,0,0,896,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,32800,60074,127,0,0,0,0,0,0,0,0,36864,2048,0,36,0,0,512,256,32768,4,0,0,64,32,36864,0,0,0,8,4,4608,0,0,0,32769,0,576,0,0,8192,4096,0,72,0,0,1024,512,0,9,0,0,128,64,8192,1,0,0,16,8,9216,0,0,0,2,1,1152,0,0,16384,8192,0,144,0,0,2048,1024,0,18,0,0,256,128,16384,2,0,0,32,16,18432,0,0,0,4,2,2304,0,0,32768,16384,0,288,0,0,4096,2048,0,36,0,0,512,256,32768,4,0,0,0,43688,0,0,0,0,0,0,0,0,0,32768,32771,0,576,0,0,0,21536,65365,3,0,0,2048,0,0,0,0,0,128,64,8192,1,0,0,0,0,0,0,0,0,16384,1365,15,0,0,0,43008,57514,1,0,0,0,21760,21,0,0,0,0,43680,2,0,0,0,0,21844,0,0,0,0,32768,2730,0,0,0,0,20480,49493,3,0,0,0,43520,30762,0,0,0,0,21824,3845,0,0,0,0,43688,480,0,0,0,0,64,0,0,0,0,0,8,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,1024,0,0,0,0,0,10912,0,0,0,0,0,1364,0,0,0,0,43010,65194,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,21826,16373,0,0,0,0,0,0,0,0,0,12,4,4608,0,0,0,0,0,0,0,0,12288,4096,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0
	])

{-# NOINLINE happyExpListPerState #-}
happyExpListPerState st =
    token_strs_expected
  where token_strs = ["error","%dummy","%start_midnight","S","Seq","Instr","Declar","Type","TComp","LValue","Exp","Slice","Funcall","Args","space","end","moon","new","full","planet","cloud","star","blackhole","cosmos","constellation","cluster","quasar","nebula","galaxy","ufo","comet","satellite","terraform","print","read","around","range","pop","add","bigbang","if","elseif","else","unless","while","until","orbit","'@'","'('","')'","'['","']'","'{'","'}'","'..'","'.'","','","';'","':'","'~'","'+='","'+'","'-='","'-'","'*='","'*'","'^='","'^'","'//='","'//'","'/='","'/'","'%='","'%'","'->'","'>='","'>'","'<='","'<'","'&&'","'&'","'||'","'|'","'=='","'\9516\188='","'='","'\9516\188'","str","chr","id","float","int","%eof"]
        bit_start = st * 93
        bit_end = (st + 1) * 93
        read_bit = readArrayBit happyExpList
        bits = map read_bit [bit_start..bit_end - 1]
        bits_indexed = zip bits [0..92]
        token_strs_expected = concatMap f bits_indexed
        f (False, _) = []
        f (True, nr) = [token_strs !! nr]

action_0 (15) = happyShift action_4
action_0 (4) = happyGoto action_3
action_0 _ = happyFail (happyExpListPerState 0)

action_1 (15) = happyShift action_2
action_1 _ = happyFail (happyExpListPerState 1)

action_2 (16) = happyShift action_11
action_2 _ = happyFail (happyExpListPerState 2)

action_3 (93) = happyAccept
action_3 _ = happyFail (happyExpListPerState 3)

action_4 (16) = happyShift action_11
action_4 (17) = happyShift action_12
action_4 (20) = happyShift action_13
action_4 (21) = happyShift action_14
action_4 (22) = happyShift action_15
action_4 (49) = happyShift action_16
action_4 (51) = happyShift action_17
action_4 (60) = happyShift action_18
action_4 (90) = happyShift action_19
action_4 (5) = happyGoto action_5
action_4 (6) = happyGoto action_6
action_4 (7) = happyGoto action_7
action_4 (8) = happyGoto action_8
action_4 (9) = happyGoto action_9
action_4 (10) = happyGoto action_10
action_4 _ = happyFail (happyExpListPerState 4)

action_5 (16) = happyShift action_36
action_5 _ = happyFail (happyExpListPerState 5)

action_6 (58) = happyShift action_35
action_6 _ = happyReduce_3

action_7 _ = happyReduce_6

action_8 (90) = happyShift action_34
action_8 _ = happyFail (happyExpListPerState 8)

action_9 _ = happyReduce_20

action_10 (51) = happyShift action_24
action_10 (56) = happyShift action_25
action_10 (61) = happyShift action_26
action_10 (63) = happyShift action_27
action_10 (65) = happyShift action_28
action_10 (67) = happyShift action_29
action_10 (69) = happyShift action_30
action_10 (71) = happyShift action_31
action_10 (74) = happyShift action_32
action_10 (86) = happyShift action_33
action_10 (12) = happyGoto action_23
action_10 _ = happyFail (happyExpListPerState 10)

action_11 _ = happyReduce_1

action_12 _ = happyReduce_19

action_13 _ = happyReduce_16

action_14 _ = happyReduce_17

action_15 _ = happyReduce_18

action_16 (49) = happyShift action_16
action_16 (90) = happyShift action_19
action_16 (10) = happyGoto action_22
action_16 _ = happyFail (happyExpListPerState 16)

action_17 (17) = happyShift action_12
action_17 (20) = happyShift action_13
action_17 (21) = happyShift action_14
action_17 (22) = happyShift action_15
action_17 (51) = happyShift action_17
action_17 (60) = happyShift action_18
action_17 (8) = happyGoto action_21
action_17 (9) = happyGoto action_9
action_17 _ = happyFail (happyExpListPerState 17)

action_18 (17) = happyShift action_12
action_18 (20) = happyShift action_13
action_18 (21) = happyShift action_14
action_18 (22) = happyShift action_15
action_18 (51) = happyShift action_17
action_18 (60) = happyShift action_18
action_18 (8) = happyGoto action_20
action_18 (9) = happyGoto action_9
action_18 _ = happyFail (happyExpListPerState 18)

action_19 _ = happyReduce_25

action_20 _ = happyReduce_24

action_21 (52) = happyShift action_54
action_21 _ = happyFail (happyExpListPerState 21)

action_22 (50) = happyShift action_53
action_22 (51) = happyShift action_24
action_22 (56) = happyShift action_25
action_22 (12) = happyGoto action_23
action_22 _ = happyFail (happyExpListPerState 22)

action_23 _ = happyReduce_27

action_24 (49) = happyShift action_16
action_24 (55) = happyShift action_52
action_24 (64) = happyShift action_41
action_24 (87) = happyShift action_42
action_24 (90) = happyShift action_19
action_24 (10) = happyGoto action_38
action_24 (11) = happyGoto action_51
action_24 (13) = happyGoto action_40
action_24 _ = happyFail (happyExpListPerState 24)

action_25 (90) = happyShift action_50
action_25 _ = happyFail (happyExpListPerState 25)

action_26 (49) = happyShift action_16
action_26 (64) = happyShift action_41
action_26 (87) = happyShift action_42
action_26 (90) = happyShift action_19
action_26 (10) = happyGoto action_38
action_26 (11) = happyGoto action_49
action_26 (13) = happyGoto action_40
action_26 _ = happyFail (happyExpListPerState 26)

action_27 (49) = happyShift action_16
action_27 (64) = happyShift action_41
action_27 (87) = happyShift action_42
action_27 (90) = happyShift action_19
action_27 (10) = happyGoto action_38
action_27 (11) = happyGoto action_48
action_27 (13) = happyGoto action_40
action_27 _ = happyFail (happyExpListPerState 27)

action_28 (49) = happyShift action_16
action_28 (64) = happyShift action_41
action_28 (87) = happyShift action_42
action_28 (90) = happyShift action_19
action_28 (10) = happyGoto action_38
action_28 (11) = happyGoto action_47
action_28 (13) = happyGoto action_40
action_28 _ = happyFail (happyExpListPerState 28)

action_29 (49) = happyShift action_16
action_29 (64) = happyShift action_41
action_29 (87) = happyShift action_42
action_29 (90) = happyShift action_19
action_29 (10) = happyGoto action_38
action_29 (11) = happyGoto action_46
action_29 (13) = happyGoto action_40
action_29 _ = happyFail (happyExpListPerState 29)

action_30 (49) = happyShift action_16
action_30 (64) = happyShift action_41
action_30 (87) = happyShift action_42
action_30 (90) = happyShift action_19
action_30 (10) = happyGoto action_38
action_30 (11) = happyGoto action_45
action_30 (13) = happyGoto action_40
action_30 _ = happyFail (happyExpListPerState 30)

action_31 (49) = happyShift action_16
action_31 (64) = happyShift action_41
action_31 (87) = happyShift action_42
action_31 (90) = happyShift action_19
action_31 (10) = happyGoto action_38
action_31 (11) = happyGoto action_44
action_31 (13) = happyGoto action_40
action_31 _ = happyFail (happyExpListPerState 31)

action_32 (49) = happyShift action_16
action_32 (64) = happyShift action_41
action_32 (87) = happyShift action_42
action_32 (90) = happyShift action_19
action_32 (10) = happyGoto action_38
action_32 (11) = happyGoto action_43
action_32 (13) = happyGoto action_40
action_32 _ = happyFail (happyExpListPerState 32)

action_33 (49) = happyShift action_16
action_33 (64) = happyShift action_41
action_33 (87) = happyShift action_42
action_33 (90) = happyShift action_19
action_33 (10) = happyGoto action_38
action_33 (11) = happyGoto action_39
action_33 (13) = happyGoto action_40
action_33 _ = happyFail (happyExpListPerState 33)

action_34 _ = happyReduce_15

action_35 (17) = happyShift action_12
action_35 (20) = happyShift action_13
action_35 (21) = happyShift action_14
action_35 (22) = happyShift action_15
action_35 (49) = happyShift action_16
action_35 (51) = happyShift action_17
action_35 (60) = happyShift action_18
action_35 (90) = happyShift action_19
action_35 (5) = happyGoto action_37
action_35 (6) = happyGoto action_6
action_35 (7) = happyGoto action_7
action_35 (8) = happyGoto action_8
action_35 (9) = happyGoto action_9
action_35 (10) = happyGoto action_10
action_35 _ = happyReduce_4

action_36 _ = happyReduce_2

action_37 _ = happyReduce_5

action_38 (49) = happyShift action_80
action_38 (51) = happyShift action_24
action_38 (56) = happyShift action_25
action_38 (12) = happyGoto action_23
action_38 _ = happyReduce_30

action_39 (62) = happyShift action_61
action_39 (64) = happyShift action_62
action_39 (66) = happyShift action_63
action_39 (68) = happyShift action_64
action_39 (70) = happyShift action_65
action_39 (72) = happyShift action_66
action_39 (74) = happyShift action_67
action_39 (76) = happyShift action_68
action_39 (77) = happyShift action_69
action_39 (78) = happyShift action_70
action_39 (79) = happyShift action_71
action_39 (80) = happyShift action_72
action_39 (81) = happyShift action_73
action_39 (82) = happyShift action_74
action_39 (83) = happyShift action_75
action_39 (84) = happyShift action_76
action_39 (85) = happyShift action_77
action_39 _ = happyReduce_7

action_40 _ = happyReduce_29

action_41 (49) = happyShift action_16
action_41 (64) = happyShift action_41
action_41 (87) = happyShift action_42
action_41 (90) = happyShift action_19
action_41 (10) = happyGoto action_38
action_41 (11) = happyGoto action_79
action_41 (13) = happyGoto action_40
action_41 _ = happyFail (happyExpListPerState 41)

action_42 (49) = happyShift action_16
action_42 (64) = happyShift action_41
action_42 (87) = happyShift action_42
action_42 (90) = happyShift action_19
action_42 (10) = happyGoto action_38
action_42 (11) = happyGoto action_78
action_42 (13) = happyGoto action_40
action_42 _ = happyFail (happyExpListPerState 42)

action_43 (62) = happyShift action_61
action_43 (64) = happyShift action_62
action_43 (66) = happyShift action_63
action_43 (68) = happyShift action_64
action_43 (70) = happyShift action_65
action_43 (72) = happyShift action_66
action_43 (74) = happyShift action_67
action_43 (76) = happyShift action_68
action_43 (77) = happyShift action_69
action_43 (78) = happyShift action_70
action_43 (79) = happyShift action_71
action_43 (80) = happyShift action_72
action_43 (81) = happyShift action_73
action_43 (82) = happyShift action_74
action_43 (83) = happyShift action_75
action_43 (84) = happyShift action_76
action_43 (85) = happyShift action_77
action_43 _ = happyReduce_13

action_44 (62) = happyShift action_61
action_44 (64) = happyShift action_62
action_44 (66) = happyShift action_63
action_44 (68) = happyShift action_64
action_44 (70) = happyShift action_65
action_44 (72) = happyShift action_66
action_44 (74) = happyShift action_67
action_44 (76) = happyShift action_68
action_44 (77) = happyShift action_69
action_44 (78) = happyShift action_70
action_44 (79) = happyShift action_71
action_44 (80) = happyShift action_72
action_44 (81) = happyShift action_73
action_44 (82) = happyShift action_74
action_44 (83) = happyShift action_75
action_44 (84) = happyShift action_76
action_44 (85) = happyShift action_77
action_44 _ = happyReduce_11

action_45 (62) = happyShift action_61
action_45 (64) = happyShift action_62
action_45 (66) = happyShift action_63
action_45 (68) = happyShift action_64
action_45 (70) = happyShift action_65
action_45 (72) = happyShift action_66
action_45 (74) = happyShift action_67
action_45 (76) = happyShift action_68
action_45 (77) = happyShift action_69
action_45 (78) = happyShift action_70
action_45 (79) = happyShift action_71
action_45 (80) = happyShift action_72
action_45 (81) = happyShift action_73
action_45 (82) = happyShift action_74
action_45 (83) = happyShift action_75
action_45 (84) = happyShift action_76
action_45 (85) = happyShift action_77
action_45 _ = happyReduce_12

action_46 (62) = happyShift action_61
action_46 (64) = happyShift action_62
action_46 (66) = happyShift action_63
action_46 (68) = happyShift action_64
action_46 (70) = happyShift action_65
action_46 (72) = happyShift action_66
action_46 (74) = happyShift action_67
action_46 (76) = happyShift action_68
action_46 (77) = happyShift action_69
action_46 (78) = happyShift action_70
action_46 (79) = happyShift action_71
action_46 (80) = happyShift action_72
action_46 (81) = happyShift action_73
action_46 (82) = happyShift action_74
action_46 (83) = happyShift action_75
action_46 (84) = happyShift action_76
action_46 (85) = happyShift action_77
action_46 _ = happyReduce_14

action_47 (62) = happyShift action_61
action_47 (64) = happyShift action_62
action_47 (66) = happyShift action_63
action_47 (68) = happyShift action_64
action_47 (70) = happyShift action_65
action_47 (72) = happyShift action_66
action_47 (74) = happyShift action_67
action_47 (76) = happyShift action_68
action_47 (77) = happyShift action_69
action_47 (78) = happyShift action_70
action_47 (79) = happyShift action_71
action_47 (80) = happyShift action_72
action_47 (81) = happyShift action_73
action_47 (82) = happyShift action_74
action_47 (83) = happyShift action_75
action_47 (84) = happyShift action_76
action_47 (85) = happyShift action_77
action_47 _ = happyReduce_10

action_48 (62) = happyShift action_61
action_48 (64) = happyShift action_62
action_48 (66) = happyShift action_63
action_48 (68) = happyShift action_64
action_48 (70) = happyShift action_65
action_48 (72) = happyShift action_66
action_48 (74) = happyShift action_67
action_48 (76) = happyShift action_68
action_48 (77) = happyShift action_69
action_48 (78) = happyShift action_70
action_48 (79) = happyShift action_71
action_48 (80) = happyShift action_72
action_48 (81) = happyShift action_73
action_48 (82) = happyShift action_74
action_48 (83) = happyShift action_75
action_48 (84) = happyShift action_76
action_48 (85) = happyShift action_77
action_48 _ = happyReduce_9

action_49 (62) = happyShift action_61
action_49 (64) = happyShift action_62
action_49 (66) = happyShift action_63
action_49 (68) = happyShift action_64
action_49 (70) = happyShift action_65
action_49 (72) = happyShift action_66
action_49 (74) = happyShift action_67
action_49 (76) = happyShift action_68
action_49 (77) = happyShift action_69
action_49 (78) = happyShift action_70
action_49 (79) = happyShift action_71
action_49 (80) = happyShift action_72
action_49 (81) = happyShift action_73
action_49 (82) = happyShift action_74
action_49 (83) = happyShift action_75
action_49 (84) = happyShift action_76
action_49 (85) = happyShift action_77
action_49 _ = happyReduce_8

action_50 _ = happyReduce_26

action_51 (52) = happyShift action_59
action_51 (55) = happyShift action_60
action_51 (62) = happyShift action_61
action_51 (64) = happyShift action_62
action_51 (66) = happyShift action_63
action_51 (68) = happyShift action_64
action_51 (70) = happyShift action_65
action_51 (72) = happyShift action_66
action_51 (74) = happyShift action_67
action_51 (76) = happyShift action_68
action_51 (77) = happyShift action_69
action_51 (78) = happyShift action_70
action_51 (79) = happyShift action_71
action_51 (80) = happyShift action_72
action_51 (81) = happyShift action_73
action_51 (82) = happyShift action_74
action_51 (83) = happyShift action_75
action_51 (84) = happyShift action_76
action_51 (85) = happyShift action_77
action_51 _ = happyFail (happyExpListPerState 51)

action_52 (49) = happyShift action_16
action_52 (64) = happyShift action_41
action_52 (87) = happyShift action_42
action_52 (90) = happyShift action_19
action_52 (10) = happyGoto action_38
action_52 (11) = happyGoto action_58
action_52 (13) = happyGoto action_40
action_52 _ = happyFail (happyExpListPerState 52)

action_53 _ = happyReduce_28

action_54 (26) = happyShift action_55
action_54 (27) = happyShift action_56
action_54 (28) = happyShift action_57
action_54 _ = happyFail (happyExpListPerState 54)

action_55 _ = happyReduce_21

action_56 _ = happyReduce_22

action_57 _ = happyReduce_23

action_58 (52) = happyShift action_105
action_58 (62) = happyShift action_61
action_58 (64) = happyShift action_62
action_58 (66) = happyShift action_63
action_58 (68) = happyShift action_64
action_58 (70) = happyShift action_65
action_58 (72) = happyShift action_66
action_58 (74) = happyShift action_67
action_58 (76) = happyShift action_68
action_58 (77) = happyShift action_69
action_58 (78) = happyShift action_70
action_58 (79) = happyShift action_71
action_58 (80) = happyShift action_72
action_58 (81) = happyShift action_73
action_58 (82) = happyShift action_74
action_58 (83) = happyShift action_75
action_58 (84) = happyShift action_76
action_58 (85) = happyShift action_77
action_58 _ = happyFail (happyExpListPerState 58)

action_59 (51) = happyFail []
action_59 (12) = happyGoto action_104
action_59 _ = happyReduce_50

action_60 (49) = happyShift action_16
action_60 (52) = happyShift action_103
action_60 (64) = happyShift action_41
action_60 (87) = happyShift action_42
action_60 (90) = happyShift action_19
action_60 (10) = happyGoto action_38
action_60 (11) = happyGoto action_102
action_60 (13) = happyGoto action_40
action_60 _ = happyFail (happyExpListPerState 60)

action_61 (49) = happyShift action_16
action_61 (64) = happyShift action_41
action_61 (87) = happyShift action_42
action_61 (90) = happyShift action_19
action_61 (10) = happyGoto action_38
action_61 (11) = happyGoto action_101
action_61 (13) = happyGoto action_40
action_61 _ = happyFail (happyExpListPerState 61)

action_62 (49) = happyShift action_16
action_62 (64) = happyShift action_41
action_62 (87) = happyShift action_42
action_62 (90) = happyShift action_19
action_62 (10) = happyGoto action_38
action_62 (11) = happyGoto action_100
action_62 (13) = happyGoto action_40
action_62 _ = happyFail (happyExpListPerState 62)

action_63 (49) = happyShift action_16
action_63 (64) = happyShift action_41
action_63 (87) = happyShift action_42
action_63 (90) = happyShift action_19
action_63 (10) = happyGoto action_38
action_63 (11) = happyGoto action_99
action_63 (13) = happyGoto action_40
action_63 _ = happyFail (happyExpListPerState 63)

action_64 (49) = happyShift action_16
action_64 (64) = happyShift action_41
action_64 (87) = happyShift action_42
action_64 (90) = happyShift action_19
action_64 (10) = happyGoto action_38
action_64 (11) = happyGoto action_98
action_64 (13) = happyGoto action_40
action_64 _ = happyFail (happyExpListPerState 64)

action_65 (49) = happyShift action_16
action_65 (64) = happyShift action_41
action_65 (87) = happyShift action_42
action_65 (90) = happyShift action_19
action_65 (10) = happyGoto action_38
action_65 (11) = happyGoto action_97
action_65 (13) = happyGoto action_40
action_65 _ = happyFail (happyExpListPerState 65)

action_66 (49) = happyShift action_16
action_66 (64) = happyShift action_41
action_66 (87) = happyShift action_42
action_66 (90) = happyShift action_19
action_66 (10) = happyGoto action_38
action_66 (11) = happyGoto action_96
action_66 (13) = happyGoto action_40
action_66 _ = happyFail (happyExpListPerState 66)

action_67 (49) = happyShift action_16
action_67 (64) = happyShift action_41
action_67 (87) = happyShift action_42
action_67 (90) = happyShift action_19
action_67 (10) = happyGoto action_38
action_67 (11) = happyGoto action_95
action_67 (13) = happyGoto action_40
action_67 _ = happyFail (happyExpListPerState 67)

action_68 (49) = happyShift action_16
action_68 (64) = happyShift action_41
action_68 (87) = happyShift action_42
action_68 (90) = happyShift action_19
action_68 (10) = happyGoto action_38
action_68 (11) = happyGoto action_94
action_68 (13) = happyGoto action_40
action_68 _ = happyFail (happyExpListPerState 68)

action_69 (49) = happyShift action_16
action_69 (64) = happyShift action_41
action_69 (87) = happyShift action_42
action_69 (90) = happyShift action_19
action_69 (10) = happyGoto action_38
action_69 (11) = happyGoto action_93
action_69 (13) = happyGoto action_40
action_69 _ = happyFail (happyExpListPerState 69)

action_70 (49) = happyShift action_16
action_70 (64) = happyShift action_41
action_70 (87) = happyShift action_42
action_70 (90) = happyShift action_19
action_70 (10) = happyGoto action_38
action_70 (11) = happyGoto action_92
action_70 (13) = happyGoto action_40
action_70 _ = happyFail (happyExpListPerState 70)

action_71 (49) = happyShift action_16
action_71 (64) = happyShift action_41
action_71 (87) = happyShift action_42
action_71 (90) = happyShift action_19
action_71 (10) = happyGoto action_38
action_71 (11) = happyGoto action_91
action_71 (13) = happyGoto action_40
action_71 _ = happyFail (happyExpListPerState 71)

action_72 (49) = happyShift action_16
action_72 (64) = happyShift action_41
action_72 (87) = happyShift action_42
action_72 (90) = happyShift action_19
action_72 (10) = happyGoto action_38
action_72 (11) = happyGoto action_90
action_72 (13) = happyGoto action_40
action_72 _ = happyFail (happyExpListPerState 72)

action_73 (49) = happyShift action_16
action_73 (64) = happyShift action_41
action_73 (87) = happyShift action_42
action_73 (90) = happyShift action_19
action_73 (10) = happyGoto action_38
action_73 (11) = happyGoto action_89
action_73 (13) = happyGoto action_40
action_73 _ = happyFail (happyExpListPerState 73)

action_74 (49) = happyShift action_16
action_74 (64) = happyShift action_41
action_74 (87) = happyShift action_42
action_74 (90) = happyShift action_19
action_74 (10) = happyGoto action_38
action_74 (11) = happyGoto action_88
action_74 (13) = happyGoto action_40
action_74 _ = happyFail (happyExpListPerState 74)

action_75 (49) = happyShift action_16
action_75 (64) = happyShift action_41
action_75 (87) = happyShift action_42
action_75 (90) = happyShift action_19
action_75 (10) = happyGoto action_38
action_75 (11) = happyGoto action_87
action_75 (13) = happyGoto action_40
action_75 _ = happyFail (happyExpListPerState 75)

action_76 (49) = happyShift action_16
action_76 (64) = happyShift action_41
action_76 (87) = happyShift action_42
action_76 (90) = happyShift action_19
action_76 (10) = happyGoto action_38
action_76 (11) = happyGoto action_86
action_76 (13) = happyGoto action_40
action_76 _ = happyFail (happyExpListPerState 76)

action_77 (49) = happyShift action_16
action_77 (64) = happyShift action_41
action_77 (87) = happyShift action_42
action_77 (90) = happyShift action_19
action_77 (10) = happyGoto action_38
action_77 (11) = happyGoto action_85
action_77 (13) = happyGoto action_40
action_77 _ = happyFail (happyExpListPerState 77)

action_78 (62) = happyShift action_61
action_78 (64) = happyShift action_62
action_78 (66) = happyShift action_63
action_78 (68) = happyShift action_64
action_78 (70) = happyShift action_65
action_78 (72) = happyShift action_66
action_78 (74) = happyShift action_67
action_78 _ = happyReduce_49

action_79 _ = happyReduce_38

action_80 (48) = happyShift action_83
action_80 (49) = happyShift action_16
action_80 (50) = happyShift action_84
action_80 (64) = happyShift action_41
action_80 (87) = happyShift action_42
action_80 (90) = happyShift action_19
action_80 (10) = happyGoto action_38
action_80 (11) = happyGoto action_81
action_80 (13) = happyGoto action_40
action_80 (14) = happyGoto action_82
action_80 _ = happyFail (happyExpListPerState 80)

action_81 (57) = happyShift action_111
action_81 (62) = happyShift action_61
action_81 (64) = happyShift action_62
action_81 (66) = happyShift action_63
action_81 (68) = happyShift action_64
action_81 (70) = happyShift action_65
action_81 (72) = happyShift action_66
action_81 (74) = happyShift action_67
action_81 (76) = happyShift action_68
action_81 (77) = happyShift action_69
action_81 (78) = happyShift action_70
action_81 (79) = happyShift action_71
action_81 (80) = happyShift action_72
action_81 (81) = happyShift action_73
action_81 (82) = happyShift action_74
action_81 (83) = happyShift action_75
action_81 (84) = happyShift action_76
action_81 (85) = happyShift action_77
action_81 _ = happyReduce_61

action_82 (50) = happyShift action_110
action_82 _ = happyFail (happyExpListPerState 82)

action_83 (49) = happyShift action_16
action_83 (64) = happyShift action_41
action_83 (87) = happyShift action_42
action_83 (90) = happyShift action_19
action_83 (10) = happyGoto action_38
action_83 (11) = happyGoto action_109
action_83 (13) = happyGoto action_40
action_83 _ = happyFail (happyExpListPerState 83)

action_84 _ = happyReduce_59

action_85 (62) = happyShift action_61
action_85 (64) = happyShift action_62
action_85 (66) = happyShift action_63
action_85 (68) = happyShift action_64
action_85 (70) = happyShift action_65
action_85 (72) = happyShift action_66
action_85 (74) = happyShift action_67
action_85 (76) = happyFail []
action_85 (77) = happyFail []
action_85 (78) = happyFail []
action_85 (79) = happyFail []
action_85 (80) = happyShift action_72
action_85 (81) = happyShift action_73
action_85 (82) = happyShift action_74
action_85 (83) = happyShift action_75
action_85 (84) = happyFail []
action_85 (85) = happyFail []
action_85 _ = happyReduce_40

action_86 (62) = happyShift action_61
action_86 (64) = happyShift action_62
action_86 (66) = happyShift action_63
action_86 (68) = happyShift action_64
action_86 (70) = happyShift action_65
action_86 (72) = happyShift action_66
action_86 (74) = happyShift action_67
action_86 (76) = happyFail []
action_86 (77) = happyFail []
action_86 (78) = happyFail []
action_86 (79) = happyFail []
action_86 (80) = happyShift action_72
action_86 (81) = happyShift action_73
action_86 (82) = happyShift action_74
action_86 (83) = happyShift action_75
action_86 (84) = happyFail []
action_86 (85) = happyFail []
action_86 _ = happyReduce_39

action_87 (62) = happyShift action_61
action_87 (64) = happyShift action_62
action_87 (66) = happyShift action_63
action_87 (68) = happyShift action_64
action_87 (70) = happyShift action_65
action_87 (72) = happyShift action_66
action_87 (74) = happyShift action_67
action_87 _ = happyReduce_48

action_88 (62) = happyShift action_61
action_88 (64) = happyShift action_62
action_88 (66) = happyShift action_63
action_88 (68) = happyShift action_64
action_88 (70) = happyShift action_65
action_88 (72) = happyShift action_66
action_88 (74) = happyShift action_67
action_88 _ = happyReduce_47

action_89 (62) = happyShift action_61
action_89 (64) = happyShift action_62
action_89 (66) = happyShift action_63
action_89 (68) = happyShift action_64
action_89 (70) = happyShift action_65
action_89 (72) = happyShift action_66
action_89 (74) = happyShift action_67
action_89 _ = happyReduce_46

action_90 (62) = happyShift action_61
action_90 (64) = happyShift action_62
action_90 (66) = happyShift action_63
action_90 (68) = happyShift action_64
action_90 (70) = happyShift action_65
action_90 (72) = happyShift action_66
action_90 (74) = happyShift action_67
action_90 _ = happyReduce_45

action_91 (62) = happyShift action_61
action_91 (64) = happyShift action_62
action_91 (66) = happyShift action_63
action_91 (68) = happyShift action_64
action_91 (70) = happyShift action_65
action_91 (72) = happyShift action_66
action_91 (74) = happyShift action_67
action_91 (76) = happyFail []
action_91 (77) = happyFail []
action_91 (78) = happyFail []
action_91 (79) = happyFail []
action_91 (80) = happyShift action_72
action_91 (81) = happyShift action_73
action_91 (82) = happyShift action_74
action_91 (83) = happyShift action_75
action_91 (84) = happyFail []
action_91 (85) = happyFail []
action_91 _ = happyReduce_43

action_92 (62) = happyShift action_61
action_92 (64) = happyShift action_62
action_92 (66) = happyShift action_63
action_92 (68) = happyShift action_64
action_92 (70) = happyShift action_65
action_92 (72) = happyShift action_66
action_92 (74) = happyShift action_67
action_92 (76) = happyFail []
action_92 (77) = happyFail []
action_92 (78) = happyFail []
action_92 (79) = happyFail []
action_92 (80) = happyShift action_72
action_92 (81) = happyShift action_73
action_92 (82) = happyShift action_74
action_92 (83) = happyShift action_75
action_92 (84) = happyFail []
action_92 (85) = happyFail []
action_92 _ = happyReduce_44

action_93 (62) = happyShift action_61
action_93 (64) = happyShift action_62
action_93 (66) = happyShift action_63
action_93 (68) = happyShift action_64
action_93 (70) = happyShift action_65
action_93 (72) = happyShift action_66
action_93 (74) = happyShift action_67
action_93 (76) = happyFail []
action_93 (77) = happyFail []
action_93 (78) = happyFail []
action_93 (79) = happyFail []
action_93 (80) = happyShift action_72
action_93 (81) = happyShift action_73
action_93 (82) = happyShift action_74
action_93 (83) = happyShift action_75
action_93 (84) = happyFail []
action_93 (85) = happyFail []
action_93 _ = happyReduce_41

action_94 (62) = happyShift action_61
action_94 (64) = happyShift action_62
action_94 (66) = happyShift action_63
action_94 (68) = happyShift action_64
action_94 (70) = happyShift action_65
action_94 (72) = happyShift action_66
action_94 (74) = happyShift action_67
action_94 (76) = happyFail []
action_94 (77) = happyFail []
action_94 (78) = happyFail []
action_94 (79) = happyFail []
action_94 (80) = happyShift action_72
action_94 (81) = happyShift action_73
action_94 (82) = happyShift action_74
action_94 (83) = happyShift action_75
action_94 (84) = happyFail []
action_94 (85) = happyFail []
action_94 _ = happyReduce_42

action_95 (68) = happyShift action_64
action_95 _ = happyReduce_36

action_96 (68) = happyShift action_64
action_96 _ = happyReduce_34

action_97 (68) = happyShift action_64
action_97 _ = happyReduce_35

action_98 (68) = happyFail []
action_98 _ = happyReduce_37

action_99 (68) = happyShift action_64
action_99 _ = happyReduce_33

action_100 (66) = happyShift action_63
action_100 (68) = happyShift action_64
action_100 (70) = happyShift action_65
action_100 (72) = happyShift action_66
action_100 (74) = happyShift action_67
action_100 _ = happyReduce_32

action_101 (66) = happyShift action_63
action_101 (68) = happyShift action_64
action_101 (70) = happyShift action_65
action_101 (72) = happyShift action_66
action_101 (74) = happyShift action_67
action_101 _ = happyReduce_31

action_102 (52) = happyShift action_108
action_102 (62) = happyShift action_61
action_102 (64) = happyShift action_62
action_102 (66) = happyShift action_63
action_102 (68) = happyShift action_64
action_102 (70) = happyShift action_65
action_102 (72) = happyShift action_66
action_102 (74) = happyShift action_67
action_102 (76) = happyShift action_68
action_102 (77) = happyShift action_69
action_102 (78) = happyShift action_70
action_102 (79) = happyShift action_71
action_102 (80) = happyShift action_72
action_102 (81) = happyShift action_73
action_102 (82) = happyShift action_74
action_102 (83) = happyShift action_75
action_102 (84) = happyShift action_76
action_102 (85) = happyShift action_77
action_102 _ = happyFail (happyExpListPerState 102)

action_103 (51) = happyFail []
action_103 (12) = happyGoto action_107
action_103 _ = happyReduce_56

action_104 _ = happyReduce_51

action_105 (51) = happyFail []
action_105 (12) = happyGoto action_106
action_105 _ = happyReduce_54

action_106 _ = happyReduce_55

action_107 _ = happyReduce_57

action_108 (51) = happyFail []
action_108 (12) = happyGoto action_114
action_108 _ = happyReduce_52

action_109 (57) = happyShift action_113
action_109 (62) = happyShift action_61
action_109 (64) = happyShift action_62
action_109 (66) = happyShift action_63
action_109 (68) = happyShift action_64
action_109 (70) = happyShift action_65
action_109 (72) = happyShift action_66
action_109 (74) = happyShift action_67
action_109 (76) = happyShift action_68
action_109 (77) = happyShift action_69
action_109 (78) = happyShift action_70
action_109 (79) = happyShift action_71
action_109 (80) = happyShift action_72
action_109 (81) = happyShift action_73
action_109 (82) = happyShift action_74
action_109 (83) = happyShift action_75
action_109 (84) = happyShift action_76
action_109 (85) = happyShift action_77
action_109 _ = happyReduce_63

action_110 _ = happyReduce_58

action_111 (48) = happyShift action_83
action_111 (49) = happyShift action_16
action_111 (64) = happyShift action_41
action_111 (87) = happyShift action_42
action_111 (90) = happyShift action_19
action_111 (10) = happyGoto action_38
action_111 (11) = happyGoto action_81
action_111 (13) = happyGoto action_40
action_111 (14) = happyGoto action_112
action_111 _ = happyFail (happyExpListPerState 111)

action_112 _ = happyReduce_60

action_113 (48) = happyShift action_83
action_113 (49) = happyShift action_16
action_113 (64) = happyShift action_41
action_113 (87) = happyShift action_42
action_113 (90) = happyShift action_19
action_113 (10) = happyGoto action_38
action_113 (11) = happyGoto action_81
action_113 (13) = happyGoto action_40
action_113 (14) = happyGoto action_115
action_113 _ = happyFail (happyExpListPerState 113)

action_114 _ = happyReduce_53

action_115 _ = happyReduce_62

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

happyReduce_8 = happySpecReduce_3  6 happyReduction_8
happyReduction_8 (HappyAbsSyn11  happy_var_3)
	_
	(HappyAbsSyn10  happy_var_1)
	 =  HappyAbsSyn6
		 (Asig happy_var_1 (Sum (Lval happy_var_1) happy_var_3)
	)
happyReduction_8 _ _ _  = notHappyAtAll 

happyReduce_9 = happySpecReduce_3  6 happyReduction_9
happyReduction_9 (HappyAbsSyn11  happy_var_3)
	_
	(HappyAbsSyn10  happy_var_1)
	 =  HappyAbsSyn6
		 (Asig happy_var_1 (Sub (Lval happy_var_1) happy_var_3)
	)
happyReduction_9 _ _ _  = notHappyAtAll 

happyReduce_10 = happySpecReduce_3  6 happyReduction_10
happyReduction_10 (HappyAbsSyn11  happy_var_3)
	_
	(HappyAbsSyn10  happy_var_1)
	 =  HappyAbsSyn6
		 (Asig happy_var_1 (Mul (Lval happy_var_1) happy_var_3)
	)
happyReduction_10 _ _ _  = notHappyAtAll 

happyReduce_11 = happySpecReduce_3  6 happyReduction_11
happyReduction_11 (HappyAbsSyn11  happy_var_3)
	_
	(HappyAbsSyn10  happy_var_1)
	 =  HappyAbsSyn6
		 (Asig happy_var_1 (Div (Lval happy_var_1) happy_var_3)
	)
happyReduction_11 _ _ _  = notHappyAtAll 

happyReduce_12 = happySpecReduce_3  6 happyReduction_12
happyReduction_12 (HappyAbsSyn11  happy_var_3)
	_
	(HappyAbsSyn10  happy_var_1)
	 =  HappyAbsSyn6
		 (Asig happy_var_1 (DivE (Lval happy_var_1) happy_var_3)
	)
happyReduction_12 _ _ _  = notHappyAtAll 

happyReduce_13 = happySpecReduce_3  6 happyReduction_13
happyReduction_13 (HappyAbsSyn11  happy_var_3)
	_
	(HappyAbsSyn10  happy_var_1)
	 =  HappyAbsSyn6
		 (Asig happy_var_1 (Mod (Lval happy_var_1) happy_var_3)
	)
happyReduction_13 _ _ _  = notHappyAtAll 

happyReduce_14 = happySpecReduce_3  6 happyReduction_14
happyReduction_14 (HappyAbsSyn11  happy_var_3)
	_
	(HappyAbsSyn10  happy_var_1)
	 =  HappyAbsSyn6
		 (Asig happy_var_1 (Pow (Lval happy_var_1) happy_var_3)
	)
happyReduction_14 _ _ _  = notHappyAtAll 

happyReduce_15 = happySpecReduce_2  7 happyReduction_15
happyReduction_15 (HappyTerminal (TkId happy_var_2))
	(HappyAbsSyn8  happy_var_1)
	 =  HappyAbsSyn7
		 (Declar happy_var_1 (fst happy_var_2)
	)
happyReduction_15 _ _  = notHappyAtAll 

happyReduce_16 = happySpecReduce_1  8 happyReduction_16
happyReduction_16 _
	 =  HappyAbsSyn8
		 (Planet
	)

happyReduce_17 = happySpecReduce_1  8 happyReduction_17
happyReduction_17 _
	 =  HappyAbsSyn8
		 (Cloud
	)

happyReduce_18 = happySpecReduce_1  8 happyReduction_18
happyReduction_18 _
	 =  HappyAbsSyn8
		 (Star
	)

happyReduce_19 = happySpecReduce_1  8 happyReduction_19
happyReduction_19 _
	 =  HappyAbsSyn8
		 (Moon
	)

happyReduce_20 = happySpecReduce_1  8 happyReduction_20
happyReduction_20 (HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn8
		 (happy_var_1
	)
happyReduction_20 _  = notHappyAtAll 

happyReduce_21 = happyReduce 4 9 happyReduction_21
happyReduction_21 (_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn8  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn9
		 (Cluster happy_var_2
	) `HappyStk` happyRest

happyReduce_22 = happyReduce 4 9 happyReduction_22
happyReduction_22 (_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn8  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn9
		 (Quasar happy_var_2
	) `HappyStk` happyRest

happyReduce_23 = happyReduce 4 9 happyReduction_23
happyReduction_23 (_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn8  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn9
		 (Nebula happy_var_2
	) `HappyStk` happyRest

happyReduce_24 = happySpecReduce_2  9 happyReduction_24
happyReduction_24 (HappyAbsSyn8  happy_var_2)
	_
	 =  HappyAbsSyn9
		 (Pointer happy_var_2
	)
happyReduction_24 _ _  = notHappyAtAll 

happyReduce_25 = happySpecReduce_1  10 happyReduction_25
happyReduction_25 (HappyTerminal (TkId happy_var_1))
	 =  HappyAbsSyn10
		 (Var (fst happy_var_1)
	)
happyReduction_25 _  = notHappyAtAll 

happyReduce_26 = happySpecReduce_3  10 happyReduction_26
happyReduction_26 (HappyTerminal (TkId happy_var_3))
	_
	(HappyAbsSyn10  happy_var_1)
	 =  HappyAbsSyn10
		 (Attr happy_var_1 (fst happy_var_3)
	)
happyReduction_26 _ _ _  = notHappyAtAll 

happyReduce_27 = happySpecReduce_2  10 happyReduction_27
happyReduction_27 (HappyAbsSyn12  happy_var_2)
	(HappyAbsSyn10  happy_var_1)
	 =  HappyAbsSyn10
		 (Access happy_var_1 happy_var_2
	)
happyReduction_27 _ _  = notHappyAtAll 

happyReduce_28 = happySpecReduce_3  10 happyReduction_28
happyReduction_28 _
	(HappyAbsSyn10  happy_var_2)
	_
	 =  HappyAbsSyn10
		 (happy_var_2
	)
happyReduction_28 _ _ _  = notHappyAtAll 

happyReduce_29 = happySpecReduce_1  11 happyReduction_29
happyReduction_29 (HappyAbsSyn13  happy_var_1)
	 =  HappyAbsSyn11
		 (happy_var_1
	)
happyReduction_29 _  = notHappyAtAll 

happyReduce_30 = happySpecReduce_1  11 happyReduction_30
happyReduction_30 (HappyAbsSyn10  happy_var_1)
	 =  HappyAbsSyn11
		 (Lval happy_var_1
	)
happyReduction_30 _  = notHappyAtAll 

happyReduce_31 = happySpecReduce_3  11 happyReduction_31
happyReduction_31 (HappyAbsSyn11  happy_var_3)
	_
	(HappyAbsSyn11  happy_var_1)
	 =  HappyAbsSyn11
		 (Sum happy_var_1 happy_var_3
	)
happyReduction_31 _ _ _  = notHappyAtAll 

happyReduce_32 = happySpecReduce_3  11 happyReduction_32
happyReduction_32 (HappyAbsSyn11  happy_var_3)
	_
	(HappyAbsSyn11  happy_var_1)
	 =  HappyAbsSyn11
		 (Sub happy_var_1 happy_var_3
	)
happyReduction_32 _ _ _  = notHappyAtAll 

happyReduce_33 = happySpecReduce_3  11 happyReduction_33
happyReduction_33 (HappyAbsSyn11  happy_var_3)
	_
	(HappyAbsSyn11  happy_var_1)
	 =  HappyAbsSyn11
		 (Mul happy_var_1 happy_var_3
	)
happyReduction_33 _ _ _  = notHappyAtAll 

happyReduce_34 = happySpecReduce_3  11 happyReduction_34
happyReduction_34 (HappyAbsSyn11  happy_var_3)
	_
	(HappyAbsSyn11  happy_var_1)
	 =  HappyAbsSyn11
		 (Div happy_var_1 happy_var_3
	)
happyReduction_34 _ _ _  = notHappyAtAll 

happyReduce_35 = happySpecReduce_3  11 happyReduction_35
happyReduction_35 (HappyAbsSyn11  happy_var_3)
	_
	(HappyAbsSyn11  happy_var_1)
	 =  HappyAbsSyn11
		 (DivE happy_var_1 happy_var_3
	)
happyReduction_35 _ _ _  = notHappyAtAll 

happyReduce_36 = happySpecReduce_3  11 happyReduction_36
happyReduction_36 (HappyAbsSyn11  happy_var_3)
	_
	(HappyAbsSyn11  happy_var_1)
	 =  HappyAbsSyn11
		 (Mod happy_var_1 happy_var_3
	)
happyReduction_36 _ _ _  = notHappyAtAll 

happyReduce_37 = happySpecReduce_3  11 happyReduction_37
happyReduction_37 (HappyAbsSyn11  happy_var_3)
	_
	(HappyAbsSyn11  happy_var_1)
	 =  HappyAbsSyn11
		 (Pow happy_var_1 happy_var_3
	)
happyReduction_37 _ _ _  = notHappyAtAll 

happyReduce_38 = happySpecReduce_2  11 happyReduction_38
happyReduction_38 (HappyAbsSyn11  happy_var_2)
	_
	 =  HappyAbsSyn11
		 (Neg happy_var_2
	)
happyReduction_38 _ _  = notHappyAtAll 

happyReduce_39 = happySpecReduce_3  11 happyReduction_39
happyReduction_39 (HappyAbsSyn11  happy_var_3)
	_
	(HappyAbsSyn11  happy_var_1)
	 =  HappyAbsSyn11
		 (Eq happy_var_1 happy_var_3
	)
happyReduction_39 _ _ _  = notHappyAtAll 

happyReduce_40 = happySpecReduce_3  11 happyReduction_40
happyReduction_40 (HappyAbsSyn11  happy_var_3)
	_
	(HappyAbsSyn11  happy_var_1)
	 =  HappyAbsSyn11
		 (Neq happy_var_1 happy_var_3
	)
happyReduction_40 _ _ _  = notHappyAtAll 

happyReduce_41 = happySpecReduce_3  11 happyReduction_41
happyReduction_41 (HappyAbsSyn11  happy_var_3)
	_
	(HappyAbsSyn11  happy_var_1)
	 =  HappyAbsSyn11
		 (Mayor happy_var_1 happy_var_3
	)
happyReduction_41 _ _ _  = notHappyAtAll 

happyReduce_42 = happySpecReduce_3  11 happyReduction_42
happyReduction_42 (HappyAbsSyn11  happy_var_3)
	_
	(HappyAbsSyn11  happy_var_1)
	 =  HappyAbsSyn11
		 (MayorI happy_var_1 happy_var_3
	)
happyReduction_42 _ _ _  = notHappyAtAll 

happyReduce_43 = happySpecReduce_3  11 happyReduction_43
happyReduction_43 (HappyAbsSyn11  happy_var_3)
	_
	(HappyAbsSyn11  happy_var_1)
	 =  HappyAbsSyn11
		 (Menor happy_var_1 happy_var_3
	)
happyReduction_43 _ _ _  = notHappyAtAll 

happyReduce_44 = happySpecReduce_3  11 happyReduction_44
happyReduction_44 (HappyAbsSyn11  happy_var_3)
	_
	(HappyAbsSyn11  happy_var_1)
	 =  HappyAbsSyn11
		 (MenorI happy_var_1 happy_var_3
	)
happyReduction_44 _ _ _  = notHappyAtAll 

happyReduce_45 = happySpecReduce_3  11 happyReduction_45
happyReduction_45 (HappyAbsSyn11  happy_var_3)
	_
	(HappyAbsSyn11  happy_var_1)
	 =  HappyAbsSyn11
		 (And happy_var_1 happy_var_3
	)
happyReduction_45 _ _ _  = notHappyAtAll 

happyReduce_46 = happySpecReduce_3  11 happyReduction_46
happyReduction_46 (HappyAbsSyn11  happy_var_3)
	_
	(HappyAbsSyn11  happy_var_1)
	 =  HappyAbsSyn11
		 (Bitand happy_var_1 happy_var_3
	)
happyReduction_46 _ _ _  = notHappyAtAll 

happyReduce_47 = happySpecReduce_3  11 happyReduction_47
happyReduction_47 (HappyAbsSyn11  happy_var_3)
	_
	(HappyAbsSyn11  happy_var_1)
	 =  HappyAbsSyn11
		 (Or happy_var_1 happy_var_3
	)
happyReduction_47 _ _ _  = notHappyAtAll 

happyReduce_48 = happySpecReduce_3  11 happyReduction_48
happyReduction_48 (HappyAbsSyn11  happy_var_3)
	_
	(HappyAbsSyn11  happy_var_1)
	 =  HappyAbsSyn11
		 (Bitor happy_var_1 happy_var_3
	)
happyReduction_48 _ _ _  = notHappyAtAll 

happyReduce_49 = happySpecReduce_2  11 happyReduction_49
happyReduction_49 (HappyAbsSyn11  happy_var_2)
	_
	 =  HappyAbsSyn11
		 (Not happy_var_2
	)
happyReduction_49 _ _  = notHappyAtAll 

happyReduce_50 = happySpecReduce_3  12 happyReduction_50
happyReduction_50 _
	(HappyAbsSyn11  happy_var_2)
	_
	 =  HappyAbsSyn12
		 (Index happy_var_2
	)
happyReduction_50 _ _ _  = notHappyAtAll 

happyReduce_51 = happyReduce 4 12 happyReduction_51
happyReduction_51 ((HappyAbsSyn12  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn11  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn12
		 (ManyAc (Index happy_var_2) happy_var_4
	) `HappyStk` happyRest

happyReduce_52 = happyReduce 5 12 happyReduction_52
happyReduction_52 (_ `HappyStk`
	(HappyAbsSyn11  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn11  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn12
		 (Interval happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_53 = happyReduce 6 12 happyReduction_53
happyReduction_53 ((HappyAbsSyn12  happy_var_6) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn11  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn11  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn12
		 (ManyAc (Interval happy_var_2 happy_var_4) happy_var_6
	) `HappyStk` happyRest

happyReduce_54 = happyReduce 4 12 happyReduction_54
happyReduction_54 (_ `HappyStk`
	(HappyAbsSyn11  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn12
		 (Interval (IntLit 0) happy_var_3
	) `HappyStk` happyRest

happyReduce_55 = happyReduce 5 12 happyReduction_55
happyReduction_55 ((HappyAbsSyn12  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn11  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn12
		 (ManyAc (Interval (IntLit 0) happy_var_3) happy_var_5
	) `HappyStk` happyRest

happyReduce_56 = happyReduce 4 12 happyReduction_56
happyReduction_56 (_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn11  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn12
		 (Begin happy_var_2
	) `HappyStk` happyRest

happyReduce_57 = happyReduce 5 12 happyReduction_57
happyReduction_57 ((HappyAbsSyn12  happy_var_5) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn11  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn12
		 (ManyAc (Begin happy_var_2) happy_var_5
	) `HappyStk` happyRest

happyReduce_58 = happyReduce 4 13 happyReduction_58
happyReduction_58 (_ `HappyStk`
	(HappyAbsSyn14  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn10  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn13
		 (Funcall happy_var_1 happy_var_3
	) `HappyStk` happyRest

happyReduce_59 = happySpecReduce_3  13 happyReduction_59
happyReduction_59 _
	_
	(HappyAbsSyn10  happy_var_1)
	 =  HappyAbsSyn13
		 (Funcall happy_var_1 []
	)
happyReduction_59 _ _ _  = notHappyAtAll 

happyReduce_60 = happySpecReduce_3  14 happyReduction_60
happyReduction_60 (HappyAbsSyn14  happy_var_3)
	_
	(HappyAbsSyn11  happy_var_1)
	 =  HappyAbsSyn14
		 ((happy_var_1, False) : happy_var_3
	)
happyReduction_60 _ _ _  = notHappyAtAll 

happyReduce_61 = happySpecReduce_1  14 happyReduction_61
happyReduction_61 (HappyAbsSyn11  happy_var_1)
	 =  HappyAbsSyn14
		 ([(happy_var_1, False)]
	)
happyReduction_61 _  = notHappyAtAll 

happyReduce_62 = happyReduce 4 14 happyReduction_62
happyReduction_62 ((HappyAbsSyn14  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn11  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn14
		 ((happy_var_2, True) : happy_var_4
	) `HappyStk` happyRest

happyReduce_63 = happySpecReduce_2  14 happyReduction_63
happyReduction_63 (HappyAbsSyn11  happy_var_2)
	_
	 =  HappyAbsSyn14
		 ([(happy_var_2, True)]
	)
happyReduction_63 _ _  = notHappyAtAll 

happyNewToken action sts stk [] =
	action 93 93 notHappyAtAll (HappyState action) sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = action i i tk (HappyState action) sts stk tks in
	case tk of {
	TkSpace     happy_dollar_dollar -> cont 15;
	TkEndofSpace happy_dollar_dollar -> cont 16;
	TkMoon      happy_dollar_dollar -> cont 17;
	TkNew       happy_dollar_dollar -> cont 18;
	TkFull      happy_dollar_dollar -> cont 19;
	TkPlanet    happy_dollar_dollar -> cont 20;
	TkCloud     happy_dollar_dollar -> cont 21;
	TkStar      happy_dollar_dollar -> cont 22;
	TkBlackhole happy_dollar_dollar -> cont 23;
	TkCosmos    happy_dollar_dollar -> cont 24;
	TkConstellation happy_dollar_dollar -> cont 25;
	TkCluster   happy_dollar_dollar -> cont 26;
	TkQuasar    happy_dollar_dollar -> cont 27;
	TkNebula    happy_dollar_dollar -> cont 28;
	TkGalaxy    happy_dollar_dollar -> cont 29;
	TkUFO       happy_dollar_dollar -> cont 30;
	TkComet     happy_dollar_dollar -> cont 31;
	TkSatellite happy_dollar_dollar -> cont 32;
	TkTerraform happy_dollar_dollar -> cont 33;
	TkPrint     happy_dollar_dollar -> cont 34;
	TkRead      happy_dollar_dollar -> cont 35;
	TkAround    happy_dollar_dollar -> cont 36;
	TkRange     happy_dollar_dollar -> cont 37;
	TkPop       happy_dollar_dollar -> cont 38;
	TkAdd       happy_dollar_dollar -> cont 39;
	TkBigbang   happy_dollar_dollar -> cont 40;
	TkIf        happy_dollar_dollar -> cont 41;
	TkElseif    happy_dollar_dollar -> cont 42;
	TkElse      happy_dollar_dollar -> cont 43;
	TkUnless    happy_dollar_dollar -> cont 44;
	TkWhile     happy_dollar_dollar -> cont 45;
	TkUntil     happy_dollar_dollar -> cont 46;
	TkOrbit     happy_dollar_dollar -> cont 47;
	TkArroba      happy_dollar_dollar -> cont 48;
	TkParA      happy_dollar_dollar -> cont 49;
	TkParC      happy_dollar_dollar -> cont 50;
	TkCorA      happy_dollar_dollar -> cont 51;
	TkCorC      happy_dollar_dollar -> cont 52;
	TkLlavA     happy_dollar_dollar -> cont 53;
	TkLlavC     happy_dollar_dollar -> cont 54;
	TkPuntopunto happy_dollar_dollar -> cont 55;
	TkPunto     happy_dollar_dollar -> cont 56;
	TkComa      happy_dollar_dollar -> cont 57;
	TkPuntoycoma happy_dollar_dollar -> cont 58;
	TkDospuntos happy_dollar_dollar -> cont 59;
	TkNyangara  happy_dollar_dollar -> cont 60;
	TkMasIgual  happy_dollar_dollar -> cont 61;
	TkMas       happy_dollar_dollar -> cont 62;
	TkMenosIgual happy_dollar_dollar -> cont 63;
	TkMenos     happy_dollar_dollar -> cont 64;
	TkMultIgual happy_dollar_dollar -> cont 65;
	TkMult     happy_dollar_dollar -> cont 66;
	TkPotenciaIgual happy_dollar_dollar -> cont 67;
	TkPotencia  happy_dollar_dollar -> cont 68;
	TkDivEnteraIgual happy_dollar_dollar -> cont 69;
	TkDivEntera happy_dollar_dollar -> cont 70;
	TkDivIgual  happy_dollar_dollar -> cont 71;
	TkDiv       happy_dollar_dollar -> cont 72;
	TkModIgual  happy_dollar_dollar -> cont 73;
	TkMod       happy_dollar_dollar -> cont 74;
	TkFlechita  happy_dollar_dollar -> cont 75;
	TkMayorIgual happy_dollar_dollar -> cont 76;
	TkMayor     happy_dollar_dollar -> cont 77;
	TkMenorIgual happy_dollar_dollar -> cont 78;
	TkMenor     happy_dollar_dollar -> cont 79;
	TkAnd       happy_dollar_dollar -> cont 80;
	TkBitand    happy_dollar_dollar -> cont 81;
	TkOr        happy_dollar_dollar -> cont 82;
	TkBitor     happy_dollar_dollar -> cont 83;
	TkIgual     happy_dollar_dollar -> cont 84;
	TkDistinto  happy_dollar_dollar -> cont 85;
	TkAsignacion happy_dollar_dollar -> cont 86;
	TkNegacion  happy_dollar_dollar -> cont 87;
	TkString happy_dollar_dollar -> cont 88;
	TkChar happy_dollar_dollar -> cont 89;
	TkId happy_dollar_dollar -> cont 90;
	TkFloat happy_dollar_dollar -> cont 91;
	TkInt happy_dollar_dollar -> cont 92;
	_ -> happyError' ((tk:tks), [])
	}

happyError_ explist 93 tk tks = happyError' (tks, explist)
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
      = Funcall LValue [(Exp, Bool)]
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
