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

data HappyAbsSyn t4 t5 t6 t7 t8 t9 t10 t11 t12 t13 t14 t15 t16 t17 t18 t19
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

happyExpList :: Happy_Data_Array.Array Int Int
happyExpList = Happy_Data_Array.listArray (0,1342) ([0,8,0,0,0,0,0,256,0,0,0,0,0,16384,0,0,0,0,0,0,0,0,0,0,0,0,65280,3891,22419,2177,0,252,8192,0,0,0,0,0,0,0,0,32768,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16384,0,0,0,0,0,0,0,0,0,32768,43074,170,16,0,0,0,0,43690,511,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2048,0,0,0,0,0,0,0,0,512,0,0,0,0,0,16384,0,0,0,1024,0,0,0,0,0,32768,0,0,0,0,0,0,16,0,0,0,0,0,512,0,0,0,0,0,16384,0,0,0,0,0,0,8,0,0,0,0,0,256,0,0,0,0,0,8384,0,0,64,0,49283,67,84,2,16128,0,0,0,0,0,0,0,3072,3842,20481,2049,0,252,49152,59007,33,4138,1,8064,0,53240,1084,1344,34,61440,3,1536,34689,43008,1024,0,126,8192,799,0,2053,0,0,0,1048,542,672,16,63488,1,33536,17344,21504,512,0,63,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,34048,0,0,0,0,0,0,21504,85,0,0,49283,67,84,2,16128,0,4192,2168,2688,64,57344,7,0,0,0,0,0,0,0,0,0,0,0,0,0,51144,0,320,2,0,0,63744,24,10240,64,0,0,0,0,0,42240,64170,31,0,0,0,1024,0,0,0,0,0,32768,0,0,0,0,0,0,4,0,0,0,0,0,4096,43690,511,0,0,0,4096,0,0,0,0,0,0,64,0,0,0,0,0,0,8192,0,0,0,0,512,43680,8186,0,0,0,0,21504,65365,3,0,0,0,32768,60074,127,0,0,0,128,0,0,0,0,0,4096,0,0,0,49152,59007,62049,4138,1,8064,0,0,64,0,0,0,0,1536,34689,43008,1024,0,126,49152,61472,16,32789,0,4032,0,0,0,64,0,0,0,33536,17344,21504,512,0,63,0,0,0,1,0,0,0,524,271,336,8,64512,0,16768,8672,10752,256,32768,31,0,0,0,0,0,0,0,0,0,0,0,0,0,8384,4336,5376,128,49152,15,6144,7684,40962,4098,0,504,0,49283,67,84,2,16128,0,4192,2168,2688,64,57344,7,3072,3842,20481,2049,0,252,32768,57409,33,42,1,8064,0,2096,1084,1344,32,61440,3,1536,34689,43008,1024,0,126,49152,61472,16,32789,0,4032,0,1048,542,672,16,63488,1,33536,17344,21504,512,0,63,24576,30736,32776,16394,0,2016,0,524,271,336,8,64512,0,16768,8672,10752,256,32768,31,12288,15368,16388,8197,0,1008,0,33030,135,168,4,32256,0,8384,4336,5376,128,49152,15,6144,7684,40962,4098,0,504,0,0,0,0,0,0,0,4192,2168,2944,64,57344,7,3072,3842,20481,2053,0,252,0,0,0,0,0,1024,0,2096,1084,1344,32,61440,3,1536,34689,43008,1024,0,126,49152,61472,16,32789,0,4032,0,1048,542,672,16,63488,1,33536,17344,21504,512,0,63,24576,30736,32776,16394,0,2016,0,524,271,336,8,64512,0,16768,8672,10752,256,32768,31,0,0,0,0,0,8,0,39423,51591,16555,4,32256,0,0,0,0,0,0,0,0,0,0,0,0,0,0,49283,67,84,2,16128,0,0,0,0,21840,4093,0,0,0,0,43520,65450,1,0,0,0,16384,62805,63,0,0,0,0,43688,2046,0,0,0,0,21760,65493,0,0,0,0,40960,64170,31,0,0,0,0,21844,1023,0,0,0,0,43648,32746,0,0,0,0,0,0,0,0,0,0,1152,43690,511,0,16768,8672,10752,256,32768,31,0,0,32768,0,0,0,0,0,0,0,0,0,0,0,0,0,43680,1922,0,0,0,0,21504,61525,0,0,0,0,32768,2730,0,0,0,0,0,21840,1,0,0,0,0,43520,42,0,0,0,0,16384,1365,0,0,0,0,0,43688,480,0,0,0,0,21760,15381,0,0,0,0,40960,33450,7,0,0,0,0,21844,240,0,0,0,0,8192,0,0,0,0,0,0,4,0,0,0,0,0,128,0,0,0,0,0,0,0,0,0,0,0,0,2,0,0,0,0,0,5456,0,0,0,0,0,43520,2,0,0,0,16384,21504,65365,3,0,0,0,32776,60074,127,0,0,0,256,0,0,0,0,0,0,0,0,0,0,0,0,16388,62805,63,0,0,0,0,0,0,0,0,0,4096,21760,65493,0,0,0,0,40962,64170,31,0,1048,606,672,16,63488,1,0,0,0,8,0,0,24576,30736,32776,16394,0,2016,0,524,271,336,8,64512,0,0,0,0,0,0,0,51200,199,16384,513,0,0,0,6393,0,16424,0,0,0,0,0,0,0,0,0,6144,7684,40962,4098,0,504,0,9088,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,32768,57409,33,42,1,8064,0,0,0,16384,43688,2046,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1024,0,0,0,0,0,32768,43008,65194,7,0,0,0,16,54613,255,0,8384,4336,5376,128,49152,15,0,0,0,21506,65365,3,0,0,0,4,0,0,0,0,0,2048,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8192,799,0,2053,0,0,0,0,0,0,0,0,0,0,0,8192,43648,32746,0,0,0,0,0,0,0,0,524,271,464,8,64512,0,0,0,0,21824,16373,0,0,0,0,43010,65194,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,40944,39033,2748,68,57344,7,65024,3891,22419,2177,0,252,32768,57409,33,42,1,8064,0,53240,19516,1374,34,61440,3,0,0,0,21776,65493,0,0,0,0,16,0,0,0,0,0,512,0,0,0,0,0,0,0,0,0,24576,30736,32776,16394,0,2016,0,0,0,16384,43690,511,0,0,0,0,0,0,0,63488,15567,24140,8709,0,1008,0,39423,51591,16555,4,32256,0,16352,12531,5497,136,49152,15,0,0,0,4,0,0,0,0,0,33800,60074,127,0,0,0,4096,0,0,0,0,0,0,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,6144,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,524,271,336,8,64512,0,0,0,0,0,0,0,0,0,32768,0,0,0,0,0,0,256,0,0,0,0,0,8192,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2048,0,0,0,0,0,8192,43536,65450,1,0,0,0,0,0,0,0,0,0,64,0,0,0,0,0,32768,0,0,0,57344,62271,31024,34837,0,4032,0,1048,542,672,16,63488,1,0,0,0,0,0,0,24576,30736,32776,16394,0,2016,0,13310,37647,33111,8,64512,0,0,0,16384,0,0,0,0,0,32768,43008,65194,7,0,0,0,16,54613,255,0,0,0,8192,0,0,0,0,0,0,0,0,0,0,0,0,64,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,49152,59007,62049,4138,1,8064,0,0,0,2048,0,0,0,0,0,6,0,0,0,0,0,0,0,0,0,0
	])

{-# NOINLINE happyExpListPerState #-}
happyExpListPerState st =
    token_strs_expected
  where token_strs = ["error","%dummy","%start_midnight","S","Seq","Instr","If","Elif","While","Type","Types","TComp","LValue","Exp","Slice","Funcall","Args","DictItems","Params","space","end","moon","new","full","planet","cloud","star","blackhole","constellation","cluster","quasar","nebula","galaxy","ufo","comet","satellite","terraform","print","read","scale","around","range","pop","add","bigbang","if","elseif","else","unless","while","until","orbit","break","continue","return","'@'","'('","')'","'['","']'","'{'","'}'","'..'","'.'","','","';'","':'","'~'","'+='","'+'","'-='","'-'","'*='","'*'","'^='","'^'","'//='","'//'","'/='","'/'","'%='","'%'","'->'","'>='","'>'","'<='","'<'","'&&'","'&'","'||'","'|'","'=='","'\9516\188='","'='","'\9516\188'","str","chr","id","float","int","%eof"]
        bit_start = st * 101
        bit_end = (st + 1) * 101
        read_bit = readArrayBit happyExpList
        bits = map read_bit [bit_start..bit_end - 1]
        bits_indexed = zip bits [0..100]
        token_strs_expected = concatMap f bits_indexed
        f (False, _) = []
        f (True, nr) = [token_strs !! nr]

action_0 (20) = happyShift action_4
action_0 (4) = happyGoto action_3
action_0 _ = happyFail (happyExpListPerState 0)

action_1 (20) = happyShift action_2
action_1 _ = happyFail (happyExpListPerState 1)

action_2 (21) = happyShift action_14
action_2 _ = happyFail (happyExpListPerState 2)

action_3 (101) = happyAccept
action_3 _ = happyFail (happyExpListPerState 3)

action_4 (21) = happyShift action_14
action_4 (22) = happyShift action_15
action_4 (23) = happyShift action_16
action_4 (24) = happyShift action_17
action_4 (25) = happyShift action_18
action_4 (26) = happyShift action_19
action_4 (27) = happyShift action_20
action_4 (28) = happyShift action_21
action_4 (29) = happyShift action_22
action_4 (30) = happyShift action_23
action_4 (33) = happyShift action_24
action_4 (34) = happyShift action_25
action_4 (37) = happyShift action_26
action_4 (38) = happyShift action_27
action_4 (39) = happyShift action_28
action_4 (40) = happyShift action_29
action_4 (45) = happyShift action_30
action_4 (46) = happyShift action_31
action_4 (49) = happyShift action_32
action_4 (52) = happyShift action_33
action_4 (53) = happyShift action_34
action_4 (54) = happyShift action_35
action_4 (55) = happyShift action_36
action_4 (57) = happyShift action_37
action_4 (59) = happyShift action_38
action_4 (61) = happyShift action_39
action_4 (68) = happyShift action_40
action_4 (72) = happyShift action_41
action_4 (95) = happyShift action_42
action_4 (96) = happyShift action_43
action_4 (97) = happyShift action_44
action_4 (98) = happyShift action_45
action_4 (99) = happyShift action_46
action_4 (100) = happyShift action_47
action_4 (5) = happyGoto action_5
action_4 (6) = happyGoto action_6
action_4 (7) = happyGoto action_7
action_4 (9) = happyGoto action_8
action_4 (10) = happyGoto action_9
action_4 (12) = happyGoto action_10
action_4 (13) = happyGoto action_11
action_4 (14) = happyGoto action_12
action_4 (16) = happyGoto action_13
action_4 _ = happyFail (happyExpListPerState 4)

action_5 (21) = happyShift action_112
action_5 _ = happyFail (happyExpListPerState 5)

action_6 (66) = happyShift action_111
action_6 _ = happyReduce_3

action_7 _ = happyReduce_17

action_8 _ = happyReduce_18

action_9 (98) = happyShift action_110
action_9 _ = happyFail (happyExpListPerState 9)

action_10 _ = happyReduce_43

action_11 (57) = happyShift action_99
action_11 (59) = happyShift action_100
action_11 (64) = happyShift action_101
action_11 (69) = happyShift action_102
action_11 (71) = happyShift action_103
action_11 (73) = happyShift action_104
action_11 (75) = happyShift action_105
action_11 (77) = happyShift action_106
action_11 (79) = happyShift action_107
action_11 (81) = happyShift action_108
action_11 (94) = happyShift action_109
action_11 (15) = happyGoto action_98
action_11 _ = happyReduce_64

action_12 (70) = happyShift action_81
action_12 (72) = happyShift action_82
action_12 (74) = happyShift action_83
action_12 (76) = happyShift action_84
action_12 (78) = happyShift action_85
action_12 (80) = happyShift action_86
action_12 (82) = happyShift action_87
action_12 (84) = happyShift action_88
action_12 (85) = happyShift action_89
action_12 (86) = happyShift action_90
action_12 (87) = happyShift action_91
action_12 (88) = happyShift action_92
action_12 (89) = happyShift action_93
action_12 (90) = happyShift action_94
action_12 (91) = happyShift action_95
action_12 (92) = happyShift action_96
action_12 (93) = happyShift action_97
action_12 _ = happyReduce_8

action_13 _ = happyReduce_58

action_14 _ = happyReduce_1

action_15 _ = happyReduce_40

action_16 _ = happyReduce_81

action_17 _ = happyReduce_82

action_18 _ = happyReduce_37

action_19 _ = happyReduce_38

action_20 _ = happyReduce_39

action_21 _ = happyReduce_41

action_22 _ = happyReduce_42

action_23 (57) = happyShift action_80
action_23 _ = happyFail (happyExpListPerState 23)

action_24 (98) = happyShift action_79
action_24 _ = happyFail (happyExpListPerState 24)

action_25 (98) = happyShift action_78
action_25 _ = happyFail (happyExpListPerState 25)

action_26 (57) = happyShift action_77
action_26 _ = happyFail (happyExpListPerState 26)

action_27 (57) = happyShift action_76
action_27 _ = happyFail (happyExpListPerState 27)

action_28 (57) = happyShift action_75
action_28 _ = happyFail (happyExpListPerState 28)

action_29 (57) = happyShift action_74
action_29 _ = happyFail (happyExpListPerState 29)

action_30 (57) = happyShift action_73
action_30 _ = happyFail (happyExpListPerState 30)

action_31 (57) = happyShift action_72
action_31 _ = happyFail (happyExpListPerState 31)

action_32 (57) = happyShift action_71
action_32 _ = happyFail (happyExpListPerState 32)

action_33 (50) = happyShift action_67
action_33 (51) = happyShift action_68
action_33 (57) = happyShift action_69
action_33 (98) = happyShift action_70
action_33 _ = happyFail (happyExpListPerState 33)

action_34 (23) = happyShift action_16
action_34 (24) = happyShift action_17
action_34 (30) = happyShift action_23
action_34 (37) = happyShift action_26
action_34 (38) = happyShift action_27
action_34 (39) = happyShift action_28
action_34 (40) = happyShift action_29
action_34 (45) = happyShift action_30
action_34 (57) = happyShift action_50
action_34 (59) = happyShift action_51
action_34 (61) = happyShift action_39
action_34 (72) = happyShift action_41
action_34 (95) = happyShift action_42
action_34 (96) = happyShift action_43
action_34 (97) = happyShift action_44
action_34 (98) = happyShift action_45
action_34 (99) = happyShift action_46
action_34 (100) = happyShift action_47
action_34 (13) = happyGoto action_48
action_34 (14) = happyGoto action_66
action_34 (16) = happyGoto action_13
action_34 _ = happyReduce_23

action_35 _ = happyReduce_25

action_36 (23) = happyShift action_16
action_36 (24) = happyShift action_17
action_36 (30) = happyShift action_23
action_36 (37) = happyShift action_26
action_36 (38) = happyShift action_27
action_36 (39) = happyShift action_28
action_36 (40) = happyShift action_29
action_36 (45) = happyShift action_30
action_36 (57) = happyShift action_50
action_36 (59) = happyShift action_51
action_36 (61) = happyShift action_39
action_36 (72) = happyShift action_41
action_36 (95) = happyShift action_42
action_36 (96) = happyShift action_43
action_36 (97) = happyShift action_44
action_36 (98) = happyShift action_45
action_36 (99) = happyShift action_46
action_36 (100) = happyShift action_47
action_36 (13) = happyGoto action_48
action_36 (14) = happyGoto action_65
action_36 (16) = happyGoto action_13
action_36 _ = happyReduce_27

action_37 (22) = happyShift action_15
action_37 (23) = happyShift action_16
action_37 (24) = happyShift action_17
action_37 (25) = happyShift action_18
action_37 (26) = happyShift action_19
action_37 (27) = happyShift action_20
action_37 (28) = happyShift action_21
action_37 (29) = happyShift action_22
action_37 (30) = happyShift action_23
action_37 (33) = happyShift action_24
action_37 (34) = happyShift action_25
action_37 (37) = happyShift action_26
action_37 (38) = happyShift action_27
action_37 (39) = happyShift action_28
action_37 (40) = happyShift action_29
action_37 (45) = happyShift action_30
action_37 (57) = happyShift action_37
action_37 (59) = happyShift action_38
action_37 (61) = happyShift action_39
action_37 (68) = happyShift action_40
action_37 (72) = happyShift action_41
action_37 (95) = happyShift action_42
action_37 (96) = happyShift action_43
action_37 (97) = happyShift action_44
action_37 (98) = happyShift action_45
action_37 (99) = happyShift action_46
action_37 (100) = happyShift action_47
action_37 (10) = happyGoto action_62
action_37 (11) = happyGoto action_63
action_37 (12) = happyGoto action_10
action_37 (13) = happyGoto action_48
action_37 (14) = happyGoto action_64
action_37 (16) = happyGoto action_13
action_37 _ = happyFail (happyExpListPerState 37)

action_38 (22) = happyShift action_15
action_38 (23) = happyShift action_16
action_38 (24) = happyShift action_17
action_38 (25) = happyShift action_18
action_38 (26) = happyShift action_19
action_38 (27) = happyShift action_20
action_38 (28) = happyShift action_21
action_38 (29) = happyShift action_22
action_38 (30) = happyShift action_23
action_38 (33) = happyShift action_24
action_38 (34) = happyShift action_25
action_38 (37) = happyShift action_26
action_38 (38) = happyShift action_27
action_38 (39) = happyShift action_28
action_38 (40) = happyShift action_29
action_38 (45) = happyShift action_30
action_38 (57) = happyShift action_37
action_38 (59) = happyShift action_38
action_38 (61) = happyShift action_39
action_38 (68) = happyShift action_40
action_38 (72) = happyShift action_41
action_38 (95) = happyShift action_42
action_38 (96) = happyShift action_43
action_38 (97) = happyShift action_44
action_38 (98) = happyShift action_45
action_38 (99) = happyShift action_46
action_38 (100) = happyShift action_47
action_38 (10) = happyGoto action_59
action_38 (12) = happyGoto action_10
action_38 (13) = happyGoto action_48
action_38 (14) = happyGoto action_60
action_38 (16) = happyGoto action_13
action_38 (17) = happyGoto action_61
action_38 _ = happyFail (happyExpListPerState 38)

action_39 (23) = happyShift action_16
action_39 (24) = happyShift action_17
action_39 (30) = happyShift action_23
action_39 (37) = happyShift action_26
action_39 (38) = happyShift action_27
action_39 (39) = happyShift action_28
action_39 (40) = happyShift action_29
action_39 (45) = happyShift action_30
action_39 (57) = happyShift action_50
action_39 (59) = happyShift action_51
action_39 (61) = happyShift action_39
action_39 (72) = happyShift action_41
action_39 (95) = happyShift action_42
action_39 (96) = happyShift action_43
action_39 (97) = happyShift action_44
action_39 (98) = happyShift action_45
action_39 (99) = happyShift action_46
action_39 (100) = happyShift action_47
action_39 (13) = happyGoto action_48
action_39 (14) = happyGoto action_56
action_39 (16) = happyGoto action_13
action_39 (17) = happyGoto action_57
action_39 (18) = happyGoto action_58
action_39 _ = happyFail (happyExpListPerState 39)

action_40 (22) = happyShift action_15
action_40 (25) = happyShift action_18
action_40 (26) = happyShift action_19
action_40 (27) = happyShift action_20
action_40 (28) = happyShift action_21
action_40 (29) = happyShift action_22
action_40 (33) = happyShift action_24
action_40 (34) = happyShift action_25
action_40 (57) = happyShift action_54
action_40 (59) = happyShift action_55
action_40 (68) = happyShift action_40
action_40 (10) = happyGoto action_53
action_40 (12) = happyGoto action_10
action_40 _ = happyFail (happyExpListPerState 40)

action_41 (23) = happyShift action_16
action_41 (24) = happyShift action_17
action_41 (30) = happyShift action_23
action_41 (37) = happyShift action_26
action_41 (38) = happyShift action_27
action_41 (39) = happyShift action_28
action_41 (40) = happyShift action_29
action_41 (45) = happyShift action_30
action_41 (57) = happyShift action_50
action_41 (59) = happyShift action_51
action_41 (61) = happyShift action_39
action_41 (72) = happyShift action_41
action_41 (95) = happyShift action_42
action_41 (96) = happyShift action_43
action_41 (97) = happyShift action_44
action_41 (98) = happyShift action_45
action_41 (99) = happyShift action_46
action_41 (100) = happyShift action_47
action_41 (13) = happyGoto action_48
action_41 (14) = happyGoto action_52
action_41 (16) = happyGoto action_13
action_41 _ = happyFail (happyExpListPerState 41)

action_42 (23) = happyShift action_16
action_42 (24) = happyShift action_17
action_42 (30) = happyShift action_23
action_42 (37) = happyShift action_26
action_42 (38) = happyShift action_27
action_42 (39) = happyShift action_28
action_42 (40) = happyShift action_29
action_42 (45) = happyShift action_30
action_42 (57) = happyShift action_50
action_42 (59) = happyShift action_51
action_42 (61) = happyShift action_39
action_42 (72) = happyShift action_41
action_42 (95) = happyShift action_42
action_42 (96) = happyShift action_43
action_42 (97) = happyShift action_44
action_42 (98) = happyShift action_45
action_42 (99) = happyShift action_46
action_42 (100) = happyShift action_47
action_42 (13) = happyGoto action_48
action_42 (14) = happyGoto action_49
action_42 (16) = happyGoto action_13
action_42 _ = happyFail (happyExpListPerState 42)

action_43 _ = happyReduce_88

action_44 _ = happyReduce_89

action_45 _ = happyReduce_54

action_46 _ = happyReduce_66

action_47 _ = happyReduce_65

action_48 (57) = happyShift action_99
action_48 (59) = happyShift action_100
action_48 (64) = happyShift action_101
action_48 (15) = happyGoto action_98
action_48 _ = happyReduce_64

action_49 (70) = happyShift action_81
action_49 (72) = happyShift action_82
action_49 (74) = happyShift action_83
action_49 (76) = happyShift action_84
action_49 (78) = happyShift action_85
action_49 (80) = happyShift action_86
action_49 (82) = happyShift action_87
action_49 _ = happyReduce_87

action_50 (23) = happyShift action_16
action_50 (24) = happyShift action_17
action_50 (30) = happyShift action_23
action_50 (37) = happyShift action_26
action_50 (38) = happyShift action_27
action_50 (39) = happyShift action_28
action_50 (40) = happyShift action_29
action_50 (45) = happyShift action_30
action_50 (57) = happyShift action_50
action_50 (59) = happyShift action_51
action_50 (61) = happyShift action_39
action_50 (72) = happyShift action_41
action_50 (95) = happyShift action_42
action_50 (96) = happyShift action_43
action_50 (97) = happyShift action_44
action_50 (98) = happyShift action_45
action_50 (99) = happyShift action_46
action_50 (100) = happyShift action_47
action_50 (13) = happyGoto action_48
action_50 (14) = happyGoto action_64
action_50 (16) = happyGoto action_13
action_50 _ = happyFail (happyExpListPerState 50)

action_51 (23) = happyShift action_16
action_51 (24) = happyShift action_17
action_51 (30) = happyShift action_23
action_51 (37) = happyShift action_26
action_51 (38) = happyShift action_27
action_51 (39) = happyShift action_28
action_51 (40) = happyShift action_29
action_51 (45) = happyShift action_30
action_51 (57) = happyShift action_50
action_51 (59) = happyShift action_51
action_51 (61) = happyShift action_39
action_51 (72) = happyShift action_41
action_51 (95) = happyShift action_42
action_51 (96) = happyShift action_43
action_51 (97) = happyShift action_44
action_51 (98) = happyShift action_45
action_51 (99) = happyShift action_46
action_51 (100) = happyShift action_47
action_51 (13) = happyGoto action_48
action_51 (14) = happyGoto action_60
action_51 (16) = happyGoto action_13
action_51 (17) = happyGoto action_61
action_51 _ = happyFail (happyExpListPerState 51)

action_52 _ = happyReduce_74

action_53 _ = happyReduce_50

action_54 (22) = happyShift action_15
action_54 (25) = happyShift action_18
action_54 (26) = happyShift action_19
action_54 (27) = happyShift action_20
action_54 (28) = happyShift action_21
action_54 (29) = happyShift action_22
action_54 (33) = happyShift action_24
action_54 (34) = happyShift action_25
action_54 (57) = happyShift action_54
action_54 (59) = happyShift action_55
action_54 (68) = happyShift action_40
action_54 (10) = happyGoto action_62
action_54 (11) = happyGoto action_63
action_54 (12) = happyGoto action_10
action_54 _ = happyFail (happyExpListPerState 54)

action_55 (22) = happyShift action_15
action_55 (25) = happyShift action_18
action_55 (26) = happyShift action_19
action_55 (27) = happyShift action_20
action_55 (28) = happyShift action_21
action_55 (29) = happyShift action_22
action_55 (33) = happyShift action_24
action_55 (34) = happyShift action_25
action_55 (57) = happyShift action_54
action_55 (59) = happyShift action_55
action_55 (68) = happyShift action_40
action_55 (10) = happyGoto action_59
action_55 (12) = happyGoto action_10
action_55 _ = happyFail (happyExpListPerState 55)

action_56 (65) = happyShift action_161
action_56 (67) = happyShift action_165
action_56 (70) = happyShift action_81
action_56 (72) = happyShift action_82
action_56 (74) = happyShift action_83
action_56 (76) = happyShift action_84
action_56 (78) = happyShift action_85
action_56 (80) = happyShift action_86
action_56 (82) = happyShift action_87
action_56 (84) = happyShift action_88
action_56 (85) = happyShift action_89
action_56 (86) = happyShift action_90
action_56 (87) = happyShift action_91
action_56 (88) = happyShift action_92
action_56 (89) = happyShift action_93
action_56 (90) = happyShift action_94
action_56 (91) = happyShift action_95
action_56 (92) = happyShift action_96
action_56 (93) = happyShift action_97
action_56 _ = happyReduce_105

action_57 (62) = happyShift action_164
action_57 _ = happyFail (happyExpListPerState 57)

action_58 (62) = happyShift action_163
action_58 _ = happyFail (happyExpListPerState 58)

action_59 (60) = happyShift action_162
action_59 _ = happyFail (happyExpListPerState 59)

action_60 (65) = happyShift action_161
action_60 (70) = happyShift action_81
action_60 (72) = happyShift action_82
action_60 (74) = happyShift action_83
action_60 (76) = happyShift action_84
action_60 (78) = happyShift action_85
action_60 (80) = happyShift action_86
action_60 (82) = happyShift action_87
action_60 (84) = happyShift action_88
action_60 (85) = happyShift action_89
action_60 (86) = happyShift action_90
action_60 (87) = happyShift action_91
action_60 (88) = happyShift action_92
action_60 (89) = happyShift action_93
action_60 (90) = happyShift action_94
action_60 (91) = happyShift action_95
action_60 (92) = happyShift action_96
action_60 (93) = happyShift action_97
action_60 _ = happyReduce_105

action_61 (60) = happyShift action_160
action_61 _ = happyFail (happyExpListPerState 61)

action_62 (65) = happyShift action_159
action_62 _ = happyReduce_44

action_63 (83) = happyShift action_158
action_63 _ = happyFail (happyExpListPerState 63)

action_64 (58) = happyShift action_157
action_64 (70) = happyShift action_81
action_64 (72) = happyShift action_82
action_64 (74) = happyShift action_83
action_64 (76) = happyShift action_84
action_64 (78) = happyShift action_85
action_64 (80) = happyShift action_86
action_64 (82) = happyShift action_87
action_64 (84) = happyShift action_88
action_64 (85) = happyShift action_89
action_64 (86) = happyShift action_90
action_64 (87) = happyShift action_91
action_64 (88) = happyShift action_92
action_64 (89) = happyShift action_93
action_64 (90) = happyShift action_94
action_64 (91) = happyShift action_95
action_64 (92) = happyShift action_96
action_64 (93) = happyShift action_97
action_64 _ = happyFail (happyExpListPerState 64)

action_65 (70) = happyShift action_81
action_65 (72) = happyShift action_82
action_65 (74) = happyShift action_83
action_65 (76) = happyShift action_84
action_65 (78) = happyShift action_85
action_65 (80) = happyShift action_86
action_65 (82) = happyShift action_87
action_65 (84) = happyShift action_88
action_65 (85) = happyShift action_89
action_65 (86) = happyShift action_90
action_65 (87) = happyShift action_91
action_65 (88) = happyShift action_92
action_65 (89) = happyShift action_93
action_65 (90) = happyShift action_94
action_65 (91) = happyShift action_95
action_65 (92) = happyShift action_96
action_65 (93) = happyShift action_97
action_65 _ = happyReduce_26

action_66 (70) = happyShift action_81
action_66 (72) = happyShift action_82
action_66 (74) = happyShift action_83
action_66 (76) = happyShift action_84
action_66 (78) = happyShift action_85
action_66 (80) = happyShift action_86
action_66 (82) = happyShift action_87
action_66 (84) = happyShift action_88
action_66 (85) = happyShift action_89
action_66 (86) = happyShift action_90
action_66 (87) = happyShift action_91
action_66 (88) = happyShift action_92
action_66 (89) = happyShift action_93
action_66 (90) = happyShift action_94
action_66 (91) = happyShift action_95
action_66 (92) = happyShift action_96
action_66 (93) = happyShift action_97
action_66 _ = happyReduce_24

action_67 (57) = happyShift action_156
action_67 _ = happyFail (happyExpListPerState 67)

action_68 (57) = happyShift action_155
action_68 _ = happyFail (happyExpListPerState 68)

action_69 (22) = happyShift action_15
action_69 (23) = happyShift action_16
action_69 (24) = happyShift action_17
action_69 (25) = happyShift action_18
action_69 (26) = happyShift action_19
action_69 (27) = happyShift action_20
action_69 (28) = happyShift action_21
action_69 (29) = happyShift action_22
action_69 (30) = happyShift action_23
action_69 (33) = happyShift action_24
action_69 (34) = happyShift action_25
action_69 (37) = happyShift action_26
action_69 (38) = happyShift action_27
action_69 (39) = happyShift action_28
action_69 (40) = happyShift action_29
action_69 (45) = happyShift action_30
action_69 (46) = happyShift action_31
action_69 (49) = happyShift action_32
action_69 (52) = happyShift action_33
action_69 (53) = happyShift action_34
action_69 (54) = happyShift action_35
action_69 (55) = happyShift action_36
action_69 (57) = happyShift action_37
action_69 (59) = happyShift action_38
action_69 (61) = happyShift action_39
action_69 (68) = happyShift action_40
action_69 (72) = happyShift action_41
action_69 (95) = happyShift action_42
action_69 (96) = happyShift action_43
action_69 (97) = happyShift action_44
action_69 (98) = happyShift action_45
action_69 (99) = happyShift action_46
action_69 (100) = happyShift action_47
action_69 (6) = happyGoto action_154
action_69 (7) = happyGoto action_7
action_69 (9) = happyGoto action_8
action_69 (10) = happyGoto action_9
action_69 (12) = happyGoto action_10
action_69 (13) = happyGoto action_11
action_69 (14) = happyGoto action_12
action_69 (16) = happyGoto action_13
action_69 _ = happyFail (happyExpListPerState 69)

action_70 (41) = happyShift action_153
action_70 _ = happyFail (happyExpListPerState 70)

action_71 (23) = happyShift action_16
action_71 (24) = happyShift action_17
action_71 (30) = happyShift action_23
action_71 (37) = happyShift action_26
action_71 (38) = happyShift action_27
action_71 (39) = happyShift action_28
action_71 (40) = happyShift action_29
action_71 (45) = happyShift action_30
action_71 (57) = happyShift action_50
action_71 (59) = happyShift action_51
action_71 (61) = happyShift action_39
action_71 (72) = happyShift action_41
action_71 (95) = happyShift action_42
action_71 (96) = happyShift action_43
action_71 (97) = happyShift action_44
action_71 (98) = happyShift action_45
action_71 (99) = happyShift action_46
action_71 (100) = happyShift action_47
action_71 (13) = happyGoto action_48
action_71 (14) = happyGoto action_152
action_71 (16) = happyGoto action_13
action_71 _ = happyFail (happyExpListPerState 71)

action_72 (23) = happyShift action_16
action_72 (24) = happyShift action_17
action_72 (30) = happyShift action_23
action_72 (37) = happyShift action_26
action_72 (38) = happyShift action_27
action_72 (39) = happyShift action_28
action_72 (40) = happyShift action_29
action_72 (45) = happyShift action_30
action_72 (57) = happyShift action_50
action_72 (59) = happyShift action_51
action_72 (61) = happyShift action_39
action_72 (72) = happyShift action_41
action_72 (95) = happyShift action_42
action_72 (96) = happyShift action_43
action_72 (97) = happyShift action_44
action_72 (98) = happyShift action_45
action_72 (99) = happyShift action_46
action_72 (100) = happyShift action_47
action_72 (13) = happyGoto action_48
action_72 (14) = happyGoto action_151
action_72 (16) = happyGoto action_13
action_72 _ = happyFail (happyExpListPerState 72)

action_73 (58) = happyShift action_150
action_73 _ = happyFail (happyExpListPerState 73)

action_74 (23) = happyShift action_16
action_74 (24) = happyShift action_17
action_74 (30) = happyShift action_23
action_74 (37) = happyShift action_26
action_74 (38) = happyShift action_27
action_74 (39) = happyShift action_28
action_74 (40) = happyShift action_29
action_74 (45) = happyShift action_30
action_74 (57) = happyShift action_50
action_74 (59) = happyShift action_51
action_74 (61) = happyShift action_39
action_74 (72) = happyShift action_41
action_74 (95) = happyShift action_42
action_74 (96) = happyShift action_43
action_74 (97) = happyShift action_44
action_74 (98) = happyShift action_45
action_74 (99) = happyShift action_46
action_74 (100) = happyShift action_47
action_74 (13) = happyGoto action_48
action_74 (14) = happyGoto action_149
action_74 (16) = happyGoto action_13
action_74 _ = happyFail (happyExpListPerState 74)

action_75 (58) = happyShift action_148
action_75 _ = happyFail (happyExpListPerState 75)

action_76 (23) = happyShift action_16
action_76 (24) = happyShift action_17
action_76 (30) = happyShift action_23
action_76 (37) = happyShift action_26
action_76 (38) = happyShift action_27
action_76 (39) = happyShift action_28
action_76 (40) = happyShift action_29
action_76 (45) = happyShift action_30
action_76 (57) = happyShift action_50
action_76 (59) = happyShift action_51
action_76 (61) = happyShift action_39
action_76 (72) = happyShift action_41
action_76 (95) = happyShift action_42
action_76 (96) = happyShift action_43
action_76 (97) = happyShift action_44
action_76 (98) = happyShift action_45
action_76 (99) = happyShift action_46
action_76 (100) = happyShift action_47
action_76 (13) = happyGoto action_48
action_76 (14) = happyGoto action_60
action_76 (16) = happyGoto action_13
action_76 (17) = happyGoto action_147
action_76 _ = happyFail (happyExpListPerState 76)

action_77 (23) = happyShift action_16
action_77 (24) = happyShift action_17
action_77 (30) = happyShift action_23
action_77 (37) = happyShift action_26
action_77 (38) = happyShift action_27
action_77 (39) = happyShift action_28
action_77 (40) = happyShift action_29
action_77 (45) = happyShift action_30
action_77 (57) = happyShift action_50
action_77 (59) = happyShift action_51
action_77 (61) = happyShift action_39
action_77 (72) = happyShift action_41
action_77 (95) = happyShift action_42
action_77 (96) = happyShift action_43
action_77 (97) = happyShift action_44
action_77 (98) = happyShift action_45
action_77 (99) = happyShift action_46
action_77 (100) = happyShift action_47
action_77 (13) = happyGoto action_48
action_77 (14) = happyGoto action_146
action_77 (16) = happyGoto action_13
action_77 _ = happyFail (happyExpListPerState 77)

action_78 _ = happyReduce_52

action_79 _ = happyReduce_51

action_80 (23) = happyShift action_16
action_80 (24) = happyShift action_17
action_80 (30) = happyShift action_23
action_80 (37) = happyShift action_26
action_80 (38) = happyShift action_27
action_80 (39) = happyShift action_28
action_80 (40) = happyShift action_29
action_80 (45) = happyShift action_30
action_80 (57) = happyShift action_50
action_80 (59) = happyShift action_51
action_80 (61) = happyShift action_39
action_80 (72) = happyShift action_41
action_80 (95) = happyShift action_42
action_80 (96) = happyShift action_43
action_80 (97) = happyShift action_44
action_80 (98) = happyShift action_45
action_80 (99) = happyShift action_46
action_80 (100) = happyShift action_47
action_80 (13) = happyGoto action_48
action_80 (14) = happyGoto action_145
action_80 (16) = happyGoto action_13
action_80 _ = happyFail (happyExpListPerState 80)

action_81 (23) = happyShift action_16
action_81 (24) = happyShift action_17
action_81 (30) = happyShift action_23
action_81 (37) = happyShift action_26
action_81 (38) = happyShift action_27
action_81 (39) = happyShift action_28
action_81 (40) = happyShift action_29
action_81 (45) = happyShift action_30
action_81 (57) = happyShift action_50
action_81 (59) = happyShift action_51
action_81 (61) = happyShift action_39
action_81 (72) = happyShift action_41
action_81 (95) = happyShift action_42
action_81 (96) = happyShift action_43
action_81 (97) = happyShift action_44
action_81 (98) = happyShift action_45
action_81 (99) = happyShift action_46
action_81 (100) = happyShift action_47
action_81 (13) = happyGoto action_48
action_81 (14) = happyGoto action_144
action_81 (16) = happyGoto action_13
action_81 _ = happyFail (happyExpListPerState 81)

action_82 (23) = happyShift action_16
action_82 (24) = happyShift action_17
action_82 (30) = happyShift action_23
action_82 (37) = happyShift action_26
action_82 (38) = happyShift action_27
action_82 (39) = happyShift action_28
action_82 (40) = happyShift action_29
action_82 (45) = happyShift action_30
action_82 (57) = happyShift action_50
action_82 (59) = happyShift action_51
action_82 (61) = happyShift action_39
action_82 (72) = happyShift action_41
action_82 (95) = happyShift action_42
action_82 (96) = happyShift action_43
action_82 (97) = happyShift action_44
action_82 (98) = happyShift action_45
action_82 (99) = happyShift action_46
action_82 (100) = happyShift action_47
action_82 (13) = happyGoto action_48
action_82 (14) = happyGoto action_143
action_82 (16) = happyGoto action_13
action_82 _ = happyFail (happyExpListPerState 82)

action_83 (23) = happyShift action_16
action_83 (24) = happyShift action_17
action_83 (30) = happyShift action_23
action_83 (37) = happyShift action_26
action_83 (38) = happyShift action_27
action_83 (39) = happyShift action_28
action_83 (40) = happyShift action_29
action_83 (45) = happyShift action_30
action_83 (57) = happyShift action_50
action_83 (59) = happyShift action_51
action_83 (61) = happyShift action_39
action_83 (72) = happyShift action_41
action_83 (95) = happyShift action_42
action_83 (96) = happyShift action_43
action_83 (97) = happyShift action_44
action_83 (98) = happyShift action_45
action_83 (99) = happyShift action_46
action_83 (100) = happyShift action_47
action_83 (13) = happyGoto action_48
action_83 (14) = happyGoto action_142
action_83 (16) = happyGoto action_13
action_83 _ = happyFail (happyExpListPerState 83)

action_84 (23) = happyShift action_16
action_84 (24) = happyShift action_17
action_84 (30) = happyShift action_23
action_84 (37) = happyShift action_26
action_84 (38) = happyShift action_27
action_84 (39) = happyShift action_28
action_84 (40) = happyShift action_29
action_84 (45) = happyShift action_30
action_84 (57) = happyShift action_50
action_84 (59) = happyShift action_51
action_84 (61) = happyShift action_39
action_84 (72) = happyShift action_41
action_84 (95) = happyShift action_42
action_84 (96) = happyShift action_43
action_84 (97) = happyShift action_44
action_84 (98) = happyShift action_45
action_84 (99) = happyShift action_46
action_84 (100) = happyShift action_47
action_84 (13) = happyGoto action_48
action_84 (14) = happyGoto action_141
action_84 (16) = happyGoto action_13
action_84 _ = happyFail (happyExpListPerState 84)

action_85 (23) = happyShift action_16
action_85 (24) = happyShift action_17
action_85 (30) = happyShift action_23
action_85 (37) = happyShift action_26
action_85 (38) = happyShift action_27
action_85 (39) = happyShift action_28
action_85 (40) = happyShift action_29
action_85 (45) = happyShift action_30
action_85 (57) = happyShift action_50
action_85 (59) = happyShift action_51
action_85 (61) = happyShift action_39
action_85 (72) = happyShift action_41
action_85 (95) = happyShift action_42
action_85 (96) = happyShift action_43
action_85 (97) = happyShift action_44
action_85 (98) = happyShift action_45
action_85 (99) = happyShift action_46
action_85 (100) = happyShift action_47
action_85 (13) = happyGoto action_48
action_85 (14) = happyGoto action_140
action_85 (16) = happyGoto action_13
action_85 _ = happyFail (happyExpListPerState 85)

action_86 (23) = happyShift action_16
action_86 (24) = happyShift action_17
action_86 (30) = happyShift action_23
action_86 (37) = happyShift action_26
action_86 (38) = happyShift action_27
action_86 (39) = happyShift action_28
action_86 (40) = happyShift action_29
action_86 (45) = happyShift action_30
action_86 (57) = happyShift action_50
action_86 (59) = happyShift action_51
action_86 (61) = happyShift action_39
action_86 (72) = happyShift action_41
action_86 (95) = happyShift action_42
action_86 (96) = happyShift action_43
action_86 (97) = happyShift action_44
action_86 (98) = happyShift action_45
action_86 (99) = happyShift action_46
action_86 (100) = happyShift action_47
action_86 (13) = happyGoto action_48
action_86 (14) = happyGoto action_139
action_86 (16) = happyGoto action_13
action_86 _ = happyFail (happyExpListPerState 86)

action_87 (23) = happyShift action_16
action_87 (24) = happyShift action_17
action_87 (30) = happyShift action_23
action_87 (37) = happyShift action_26
action_87 (38) = happyShift action_27
action_87 (39) = happyShift action_28
action_87 (40) = happyShift action_29
action_87 (45) = happyShift action_30
action_87 (57) = happyShift action_50
action_87 (59) = happyShift action_51
action_87 (61) = happyShift action_39
action_87 (72) = happyShift action_41
action_87 (95) = happyShift action_42
action_87 (96) = happyShift action_43
action_87 (97) = happyShift action_44
action_87 (98) = happyShift action_45
action_87 (99) = happyShift action_46
action_87 (100) = happyShift action_47
action_87 (13) = happyGoto action_48
action_87 (14) = happyGoto action_138
action_87 (16) = happyGoto action_13
action_87 _ = happyFail (happyExpListPerState 87)

action_88 (23) = happyShift action_16
action_88 (24) = happyShift action_17
action_88 (30) = happyShift action_23
action_88 (37) = happyShift action_26
action_88 (38) = happyShift action_27
action_88 (39) = happyShift action_28
action_88 (40) = happyShift action_29
action_88 (45) = happyShift action_30
action_88 (57) = happyShift action_50
action_88 (59) = happyShift action_51
action_88 (61) = happyShift action_39
action_88 (72) = happyShift action_41
action_88 (95) = happyShift action_42
action_88 (96) = happyShift action_43
action_88 (97) = happyShift action_44
action_88 (98) = happyShift action_45
action_88 (99) = happyShift action_46
action_88 (100) = happyShift action_47
action_88 (13) = happyGoto action_48
action_88 (14) = happyGoto action_137
action_88 (16) = happyGoto action_13
action_88 _ = happyFail (happyExpListPerState 88)

action_89 (23) = happyShift action_16
action_89 (24) = happyShift action_17
action_89 (30) = happyShift action_23
action_89 (37) = happyShift action_26
action_89 (38) = happyShift action_27
action_89 (39) = happyShift action_28
action_89 (40) = happyShift action_29
action_89 (45) = happyShift action_30
action_89 (57) = happyShift action_50
action_89 (59) = happyShift action_51
action_89 (61) = happyShift action_39
action_89 (72) = happyShift action_41
action_89 (95) = happyShift action_42
action_89 (96) = happyShift action_43
action_89 (97) = happyShift action_44
action_89 (98) = happyShift action_45
action_89 (99) = happyShift action_46
action_89 (100) = happyShift action_47
action_89 (13) = happyGoto action_48
action_89 (14) = happyGoto action_136
action_89 (16) = happyGoto action_13
action_89 _ = happyFail (happyExpListPerState 89)

action_90 (23) = happyShift action_16
action_90 (24) = happyShift action_17
action_90 (30) = happyShift action_23
action_90 (37) = happyShift action_26
action_90 (38) = happyShift action_27
action_90 (39) = happyShift action_28
action_90 (40) = happyShift action_29
action_90 (45) = happyShift action_30
action_90 (57) = happyShift action_50
action_90 (59) = happyShift action_51
action_90 (61) = happyShift action_39
action_90 (72) = happyShift action_41
action_90 (95) = happyShift action_42
action_90 (96) = happyShift action_43
action_90 (97) = happyShift action_44
action_90 (98) = happyShift action_45
action_90 (99) = happyShift action_46
action_90 (100) = happyShift action_47
action_90 (13) = happyGoto action_48
action_90 (14) = happyGoto action_135
action_90 (16) = happyGoto action_13
action_90 _ = happyFail (happyExpListPerState 90)

action_91 (23) = happyShift action_16
action_91 (24) = happyShift action_17
action_91 (30) = happyShift action_23
action_91 (37) = happyShift action_26
action_91 (38) = happyShift action_27
action_91 (39) = happyShift action_28
action_91 (40) = happyShift action_29
action_91 (45) = happyShift action_30
action_91 (57) = happyShift action_50
action_91 (59) = happyShift action_51
action_91 (61) = happyShift action_39
action_91 (72) = happyShift action_41
action_91 (95) = happyShift action_42
action_91 (96) = happyShift action_43
action_91 (97) = happyShift action_44
action_91 (98) = happyShift action_45
action_91 (99) = happyShift action_46
action_91 (100) = happyShift action_47
action_91 (13) = happyGoto action_48
action_91 (14) = happyGoto action_134
action_91 (16) = happyGoto action_13
action_91 _ = happyFail (happyExpListPerState 91)

action_92 (23) = happyShift action_16
action_92 (24) = happyShift action_17
action_92 (30) = happyShift action_23
action_92 (37) = happyShift action_26
action_92 (38) = happyShift action_27
action_92 (39) = happyShift action_28
action_92 (40) = happyShift action_29
action_92 (45) = happyShift action_30
action_92 (57) = happyShift action_50
action_92 (59) = happyShift action_51
action_92 (61) = happyShift action_39
action_92 (72) = happyShift action_41
action_92 (95) = happyShift action_42
action_92 (96) = happyShift action_43
action_92 (97) = happyShift action_44
action_92 (98) = happyShift action_45
action_92 (99) = happyShift action_46
action_92 (100) = happyShift action_47
action_92 (13) = happyGoto action_48
action_92 (14) = happyGoto action_133
action_92 (16) = happyGoto action_13
action_92 _ = happyFail (happyExpListPerState 92)

action_93 (23) = happyShift action_16
action_93 (24) = happyShift action_17
action_93 (30) = happyShift action_23
action_93 (37) = happyShift action_26
action_93 (38) = happyShift action_27
action_93 (39) = happyShift action_28
action_93 (40) = happyShift action_29
action_93 (45) = happyShift action_30
action_93 (57) = happyShift action_50
action_93 (59) = happyShift action_51
action_93 (61) = happyShift action_39
action_93 (72) = happyShift action_41
action_93 (95) = happyShift action_42
action_93 (96) = happyShift action_43
action_93 (97) = happyShift action_44
action_93 (98) = happyShift action_45
action_93 (99) = happyShift action_46
action_93 (100) = happyShift action_47
action_93 (13) = happyGoto action_48
action_93 (14) = happyGoto action_132
action_93 (16) = happyGoto action_13
action_93 _ = happyFail (happyExpListPerState 93)

action_94 (23) = happyShift action_16
action_94 (24) = happyShift action_17
action_94 (30) = happyShift action_23
action_94 (37) = happyShift action_26
action_94 (38) = happyShift action_27
action_94 (39) = happyShift action_28
action_94 (40) = happyShift action_29
action_94 (45) = happyShift action_30
action_94 (57) = happyShift action_50
action_94 (59) = happyShift action_51
action_94 (61) = happyShift action_39
action_94 (72) = happyShift action_41
action_94 (95) = happyShift action_42
action_94 (96) = happyShift action_43
action_94 (97) = happyShift action_44
action_94 (98) = happyShift action_45
action_94 (99) = happyShift action_46
action_94 (100) = happyShift action_47
action_94 (13) = happyGoto action_48
action_94 (14) = happyGoto action_131
action_94 (16) = happyGoto action_13
action_94 _ = happyFail (happyExpListPerState 94)

action_95 (23) = happyShift action_16
action_95 (24) = happyShift action_17
action_95 (30) = happyShift action_23
action_95 (37) = happyShift action_26
action_95 (38) = happyShift action_27
action_95 (39) = happyShift action_28
action_95 (40) = happyShift action_29
action_95 (45) = happyShift action_30
action_95 (57) = happyShift action_50
action_95 (59) = happyShift action_51
action_95 (61) = happyShift action_39
action_95 (72) = happyShift action_41
action_95 (95) = happyShift action_42
action_95 (96) = happyShift action_43
action_95 (97) = happyShift action_44
action_95 (98) = happyShift action_45
action_95 (99) = happyShift action_46
action_95 (100) = happyShift action_47
action_95 (13) = happyGoto action_48
action_95 (14) = happyGoto action_130
action_95 (16) = happyGoto action_13
action_95 _ = happyFail (happyExpListPerState 95)

action_96 (23) = happyShift action_16
action_96 (24) = happyShift action_17
action_96 (30) = happyShift action_23
action_96 (37) = happyShift action_26
action_96 (38) = happyShift action_27
action_96 (39) = happyShift action_28
action_96 (40) = happyShift action_29
action_96 (45) = happyShift action_30
action_96 (57) = happyShift action_50
action_96 (59) = happyShift action_51
action_96 (61) = happyShift action_39
action_96 (72) = happyShift action_41
action_96 (95) = happyShift action_42
action_96 (96) = happyShift action_43
action_96 (97) = happyShift action_44
action_96 (98) = happyShift action_45
action_96 (99) = happyShift action_46
action_96 (100) = happyShift action_47
action_96 (13) = happyGoto action_48
action_96 (14) = happyGoto action_129
action_96 (16) = happyGoto action_13
action_96 _ = happyFail (happyExpListPerState 96)

action_97 (23) = happyShift action_16
action_97 (24) = happyShift action_17
action_97 (30) = happyShift action_23
action_97 (37) = happyShift action_26
action_97 (38) = happyShift action_27
action_97 (39) = happyShift action_28
action_97 (40) = happyShift action_29
action_97 (45) = happyShift action_30
action_97 (57) = happyShift action_50
action_97 (59) = happyShift action_51
action_97 (61) = happyShift action_39
action_97 (72) = happyShift action_41
action_97 (95) = happyShift action_42
action_97 (96) = happyShift action_43
action_97 (97) = happyShift action_44
action_97 (98) = happyShift action_45
action_97 (99) = happyShift action_46
action_97 (100) = happyShift action_47
action_97 (13) = happyGoto action_48
action_97 (14) = happyGoto action_128
action_97 (16) = happyGoto action_13
action_97 _ = happyFail (happyExpListPerState 97)

action_98 _ = happyReduce_56

action_99 (23) = happyShift action_16
action_99 (24) = happyShift action_17
action_99 (30) = happyShift action_23
action_99 (37) = happyShift action_26
action_99 (38) = happyShift action_27
action_99 (39) = happyShift action_28
action_99 (40) = happyShift action_29
action_99 (45) = happyShift action_30
action_99 (57) = happyShift action_50
action_99 (58) = happyShift action_127
action_99 (59) = happyShift action_51
action_99 (61) = happyShift action_39
action_99 (72) = happyShift action_41
action_99 (95) = happyShift action_42
action_99 (96) = happyShift action_43
action_99 (97) = happyShift action_44
action_99 (98) = happyShift action_45
action_99 (99) = happyShift action_46
action_99 (100) = happyShift action_47
action_99 (13) = happyGoto action_48
action_99 (14) = happyGoto action_60
action_99 (16) = happyGoto action_13
action_99 (17) = happyGoto action_126
action_99 _ = happyFail (happyExpListPerState 99)

action_100 (23) = happyShift action_16
action_100 (24) = happyShift action_17
action_100 (30) = happyShift action_23
action_100 (37) = happyShift action_26
action_100 (38) = happyShift action_27
action_100 (39) = happyShift action_28
action_100 (40) = happyShift action_29
action_100 (45) = happyShift action_30
action_100 (57) = happyShift action_50
action_100 (59) = happyShift action_51
action_100 (61) = happyShift action_39
action_100 (63) = happyShift action_125
action_100 (72) = happyShift action_41
action_100 (95) = happyShift action_42
action_100 (96) = happyShift action_43
action_100 (97) = happyShift action_44
action_100 (98) = happyShift action_45
action_100 (99) = happyShift action_46
action_100 (100) = happyShift action_47
action_100 (13) = happyGoto action_48
action_100 (14) = happyGoto action_124
action_100 (16) = happyGoto action_13
action_100 _ = happyFail (happyExpListPerState 100)

action_101 (98) = happyShift action_123
action_101 _ = happyFail (happyExpListPerState 101)

action_102 (23) = happyShift action_16
action_102 (24) = happyShift action_17
action_102 (30) = happyShift action_23
action_102 (37) = happyShift action_26
action_102 (38) = happyShift action_27
action_102 (39) = happyShift action_28
action_102 (40) = happyShift action_29
action_102 (45) = happyShift action_30
action_102 (57) = happyShift action_50
action_102 (59) = happyShift action_51
action_102 (61) = happyShift action_39
action_102 (72) = happyShift action_41
action_102 (95) = happyShift action_42
action_102 (96) = happyShift action_43
action_102 (97) = happyShift action_44
action_102 (98) = happyShift action_45
action_102 (99) = happyShift action_46
action_102 (100) = happyShift action_47
action_102 (13) = happyGoto action_48
action_102 (14) = happyGoto action_122
action_102 (16) = happyGoto action_13
action_102 _ = happyFail (happyExpListPerState 102)

action_103 (23) = happyShift action_16
action_103 (24) = happyShift action_17
action_103 (30) = happyShift action_23
action_103 (37) = happyShift action_26
action_103 (38) = happyShift action_27
action_103 (39) = happyShift action_28
action_103 (40) = happyShift action_29
action_103 (45) = happyShift action_30
action_103 (57) = happyShift action_50
action_103 (59) = happyShift action_51
action_103 (61) = happyShift action_39
action_103 (72) = happyShift action_41
action_103 (95) = happyShift action_42
action_103 (96) = happyShift action_43
action_103 (97) = happyShift action_44
action_103 (98) = happyShift action_45
action_103 (99) = happyShift action_46
action_103 (100) = happyShift action_47
action_103 (13) = happyGoto action_48
action_103 (14) = happyGoto action_121
action_103 (16) = happyGoto action_13
action_103 _ = happyFail (happyExpListPerState 103)

action_104 (23) = happyShift action_16
action_104 (24) = happyShift action_17
action_104 (30) = happyShift action_23
action_104 (37) = happyShift action_26
action_104 (38) = happyShift action_27
action_104 (39) = happyShift action_28
action_104 (40) = happyShift action_29
action_104 (45) = happyShift action_30
action_104 (57) = happyShift action_50
action_104 (59) = happyShift action_51
action_104 (61) = happyShift action_39
action_104 (72) = happyShift action_41
action_104 (95) = happyShift action_42
action_104 (96) = happyShift action_43
action_104 (97) = happyShift action_44
action_104 (98) = happyShift action_45
action_104 (99) = happyShift action_46
action_104 (100) = happyShift action_47
action_104 (13) = happyGoto action_48
action_104 (14) = happyGoto action_120
action_104 (16) = happyGoto action_13
action_104 _ = happyFail (happyExpListPerState 104)

action_105 (23) = happyShift action_16
action_105 (24) = happyShift action_17
action_105 (30) = happyShift action_23
action_105 (37) = happyShift action_26
action_105 (38) = happyShift action_27
action_105 (39) = happyShift action_28
action_105 (40) = happyShift action_29
action_105 (45) = happyShift action_30
action_105 (57) = happyShift action_50
action_105 (59) = happyShift action_51
action_105 (61) = happyShift action_39
action_105 (72) = happyShift action_41
action_105 (95) = happyShift action_42
action_105 (96) = happyShift action_43
action_105 (97) = happyShift action_44
action_105 (98) = happyShift action_45
action_105 (99) = happyShift action_46
action_105 (100) = happyShift action_47
action_105 (13) = happyGoto action_48
action_105 (14) = happyGoto action_119
action_105 (16) = happyGoto action_13
action_105 _ = happyFail (happyExpListPerState 105)

action_106 (23) = happyShift action_16
action_106 (24) = happyShift action_17
action_106 (30) = happyShift action_23
action_106 (37) = happyShift action_26
action_106 (38) = happyShift action_27
action_106 (39) = happyShift action_28
action_106 (40) = happyShift action_29
action_106 (45) = happyShift action_30
action_106 (57) = happyShift action_50
action_106 (59) = happyShift action_51
action_106 (61) = happyShift action_39
action_106 (72) = happyShift action_41
action_106 (95) = happyShift action_42
action_106 (96) = happyShift action_43
action_106 (97) = happyShift action_44
action_106 (98) = happyShift action_45
action_106 (99) = happyShift action_46
action_106 (100) = happyShift action_47
action_106 (13) = happyGoto action_48
action_106 (14) = happyGoto action_118
action_106 (16) = happyGoto action_13
action_106 _ = happyFail (happyExpListPerState 106)

action_107 (23) = happyShift action_16
action_107 (24) = happyShift action_17
action_107 (30) = happyShift action_23
action_107 (37) = happyShift action_26
action_107 (38) = happyShift action_27
action_107 (39) = happyShift action_28
action_107 (40) = happyShift action_29
action_107 (45) = happyShift action_30
action_107 (57) = happyShift action_50
action_107 (59) = happyShift action_51
action_107 (61) = happyShift action_39
action_107 (72) = happyShift action_41
action_107 (95) = happyShift action_42
action_107 (96) = happyShift action_43
action_107 (97) = happyShift action_44
action_107 (98) = happyShift action_45
action_107 (99) = happyShift action_46
action_107 (100) = happyShift action_47
action_107 (13) = happyGoto action_48
action_107 (14) = happyGoto action_117
action_107 (16) = happyGoto action_13
action_107 _ = happyFail (happyExpListPerState 107)

action_108 (23) = happyShift action_16
action_108 (24) = happyShift action_17
action_108 (30) = happyShift action_23
action_108 (37) = happyShift action_26
action_108 (38) = happyShift action_27
action_108 (39) = happyShift action_28
action_108 (40) = happyShift action_29
action_108 (45) = happyShift action_30
action_108 (57) = happyShift action_50
action_108 (59) = happyShift action_51
action_108 (61) = happyShift action_39
action_108 (72) = happyShift action_41
action_108 (95) = happyShift action_42
action_108 (96) = happyShift action_43
action_108 (97) = happyShift action_44
action_108 (98) = happyShift action_45
action_108 (99) = happyShift action_46
action_108 (100) = happyShift action_47
action_108 (13) = happyGoto action_48
action_108 (14) = happyGoto action_116
action_108 (16) = happyGoto action_13
action_108 _ = happyFail (happyExpListPerState 108)

action_109 (23) = happyShift action_16
action_109 (24) = happyShift action_17
action_109 (30) = happyShift action_23
action_109 (37) = happyShift action_26
action_109 (38) = happyShift action_27
action_109 (39) = happyShift action_28
action_109 (40) = happyShift action_29
action_109 (45) = happyShift action_30
action_109 (57) = happyShift action_50
action_109 (59) = happyShift action_51
action_109 (61) = happyShift action_39
action_109 (72) = happyShift action_41
action_109 (95) = happyShift action_42
action_109 (96) = happyShift action_43
action_109 (97) = happyShift action_44
action_109 (98) = happyShift action_45
action_109 (99) = happyShift action_46
action_109 (100) = happyShift action_47
action_109 (13) = happyGoto action_48
action_109 (14) = happyGoto action_115
action_109 (16) = happyGoto action_13
action_109 _ = happyFail (happyExpListPerState 109)

action_110 (94) = happyShift action_114
action_110 _ = happyReduce_6

action_111 (22) = happyShift action_15
action_111 (23) = happyShift action_16
action_111 (24) = happyShift action_17
action_111 (25) = happyShift action_18
action_111 (26) = happyShift action_19
action_111 (27) = happyShift action_20
action_111 (28) = happyShift action_21
action_111 (29) = happyShift action_22
action_111 (30) = happyShift action_23
action_111 (33) = happyShift action_24
action_111 (34) = happyShift action_25
action_111 (37) = happyShift action_26
action_111 (38) = happyShift action_27
action_111 (39) = happyShift action_28
action_111 (40) = happyShift action_29
action_111 (45) = happyShift action_30
action_111 (46) = happyShift action_31
action_111 (49) = happyShift action_32
action_111 (52) = happyShift action_33
action_111 (53) = happyShift action_34
action_111 (54) = happyShift action_35
action_111 (55) = happyShift action_36
action_111 (57) = happyShift action_37
action_111 (59) = happyShift action_38
action_111 (61) = happyShift action_39
action_111 (68) = happyShift action_40
action_111 (72) = happyShift action_41
action_111 (95) = happyShift action_42
action_111 (96) = happyShift action_43
action_111 (97) = happyShift action_44
action_111 (98) = happyShift action_45
action_111 (99) = happyShift action_46
action_111 (100) = happyShift action_47
action_111 (5) = happyGoto action_113
action_111 (6) = happyGoto action_6
action_111 (7) = happyGoto action_7
action_111 (9) = happyGoto action_8
action_111 (10) = happyGoto action_9
action_111 (12) = happyGoto action_10
action_111 (13) = happyGoto action_11
action_111 (14) = happyGoto action_12
action_111 (16) = happyGoto action_13
action_111 _ = happyReduce_4

action_112 _ = happyReduce_2

action_113 _ = happyReduce_5

action_114 (23) = happyShift action_16
action_114 (24) = happyShift action_17
action_114 (30) = happyShift action_23
action_114 (37) = happyShift action_26
action_114 (38) = happyShift action_27
action_114 (39) = happyShift action_28
action_114 (40) = happyShift action_29
action_114 (45) = happyShift action_30
action_114 (57) = happyShift action_50
action_114 (59) = happyShift action_51
action_114 (61) = happyShift action_39
action_114 (72) = happyShift action_41
action_114 (95) = happyShift action_42
action_114 (96) = happyShift action_43
action_114 (97) = happyShift action_44
action_114 (98) = happyShift action_45
action_114 (99) = happyShift action_46
action_114 (100) = happyShift action_47
action_114 (13) = happyGoto action_48
action_114 (14) = happyGoto action_189
action_114 (16) = happyGoto action_13
action_114 _ = happyFail (happyExpListPerState 114)

action_115 (70) = happyShift action_81
action_115 (72) = happyShift action_82
action_115 (74) = happyShift action_83
action_115 (76) = happyShift action_84
action_115 (78) = happyShift action_85
action_115 (80) = happyShift action_86
action_115 (82) = happyShift action_87
action_115 (84) = happyShift action_88
action_115 (85) = happyShift action_89
action_115 (86) = happyShift action_90
action_115 (87) = happyShift action_91
action_115 (88) = happyShift action_92
action_115 (89) = happyShift action_93
action_115 (90) = happyShift action_94
action_115 (91) = happyShift action_95
action_115 (92) = happyShift action_96
action_115 (93) = happyShift action_97
action_115 _ = happyReduce_9

action_116 (70) = happyShift action_81
action_116 (72) = happyShift action_82
action_116 (74) = happyShift action_83
action_116 (76) = happyShift action_84
action_116 (78) = happyShift action_85
action_116 (80) = happyShift action_86
action_116 (82) = happyShift action_87
action_116 (84) = happyShift action_88
action_116 (85) = happyShift action_89
action_116 (86) = happyShift action_90
action_116 (87) = happyShift action_91
action_116 (88) = happyShift action_92
action_116 (89) = happyShift action_93
action_116 (90) = happyShift action_94
action_116 (91) = happyShift action_95
action_116 (92) = happyShift action_96
action_116 (93) = happyShift action_97
action_116 _ = happyReduce_15

action_117 (70) = happyShift action_81
action_117 (72) = happyShift action_82
action_117 (74) = happyShift action_83
action_117 (76) = happyShift action_84
action_117 (78) = happyShift action_85
action_117 (80) = happyShift action_86
action_117 (82) = happyShift action_87
action_117 (84) = happyShift action_88
action_117 (85) = happyShift action_89
action_117 (86) = happyShift action_90
action_117 (87) = happyShift action_91
action_117 (88) = happyShift action_92
action_117 (89) = happyShift action_93
action_117 (90) = happyShift action_94
action_117 (91) = happyShift action_95
action_117 (92) = happyShift action_96
action_117 (93) = happyShift action_97
action_117 _ = happyReduce_13

action_118 (70) = happyShift action_81
action_118 (72) = happyShift action_82
action_118 (74) = happyShift action_83
action_118 (76) = happyShift action_84
action_118 (78) = happyShift action_85
action_118 (80) = happyShift action_86
action_118 (82) = happyShift action_87
action_118 (84) = happyShift action_88
action_118 (85) = happyShift action_89
action_118 (86) = happyShift action_90
action_118 (87) = happyShift action_91
action_118 (88) = happyShift action_92
action_118 (89) = happyShift action_93
action_118 (90) = happyShift action_94
action_118 (91) = happyShift action_95
action_118 (92) = happyShift action_96
action_118 (93) = happyShift action_97
action_118 _ = happyReduce_14

action_119 (70) = happyShift action_81
action_119 (72) = happyShift action_82
action_119 (74) = happyShift action_83
action_119 (76) = happyShift action_84
action_119 (78) = happyShift action_85
action_119 (80) = happyShift action_86
action_119 (82) = happyShift action_87
action_119 (84) = happyShift action_88
action_119 (85) = happyShift action_89
action_119 (86) = happyShift action_90
action_119 (87) = happyShift action_91
action_119 (88) = happyShift action_92
action_119 (89) = happyShift action_93
action_119 (90) = happyShift action_94
action_119 (91) = happyShift action_95
action_119 (92) = happyShift action_96
action_119 (93) = happyShift action_97
action_119 _ = happyReduce_16

action_120 (70) = happyShift action_81
action_120 (72) = happyShift action_82
action_120 (74) = happyShift action_83
action_120 (76) = happyShift action_84
action_120 (78) = happyShift action_85
action_120 (80) = happyShift action_86
action_120 (82) = happyShift action_87
action_120 (84) = happyShift action_88
action_120 (85) = happyShift action_89
action_120 (86) = happyShift action_90
action_120 (87) = happyShift action_91
action_120 (88) = happyShift action_92
action_120 (89) = happyShift action_93
action_120 (90) = happyShift action_94
action_120 (91) = happyShift action_95
action_120 (92) = happyShift action_96
action_120 (93) = happyShift action_97
action_120 _ = happyReduce_12

action_121 (70) = happyShift action_81
action_121 (72) = happyShift action_82
action_121 (74) = happyShift action_83
action_121 (76) = happyShift action_84
action_121 (78) = happyShift action_85
action_121 (80) = happyShift action_86
action_121 (82) = happyShift action_87
action_121 (84) = happyShift action_88
action_121 (85) = happyShift action_89
action_121 (86) = happyShift action_90
action_121 (87) = happyShift action_91
action_121 (88) = happyShift action_92
action_121 (89) = happyShift action_93
action_121 (90) = happyShift action_94
action_121 (91) = happyShift action_95
action_121 (92) = happyShift action_96
action_121 (93) = happyShift action_97
action_121 _ = happyReduce_11

action_122 (70) = happyShift action_81
action_122 (72) = happyShift action_82
action_122 (74) = happyShift action_83
action_122 (76) = happyShift action_84
action_122 (78) = happyShift action_85
action_122 (80) = happyShift action_86
action_122 (82) = happyShift action_87
action_122 (84) = happyShift action_88
action_122 (85) = happyShift action_89
action_122 (86) = happyShift action_90
action_122 (87) = happyShift action_91
action_122 (88) = happyShift action_92
action_122 (89) = happyShift action_93
action_122 (90) = happyShift action_94
action_122 (91) = happyShift action_95
action_122 (92) = happyShift action_96
action_122 (93) = happyShift action_97
action_122 _ = happyReduce_10

action_123 _ = happyReduce_55

action_124 (60) = happyShift action_187
action_124 (63) = happyShift action_188
action_124 (70) = happyShift action_81
action_124 (72) = happyShift action_82
action_124 (74) = happyShift action_83
action_124 (76) = happyShift action_84
action_124 (78) = happyShift action_85
action_124 (80) = happyShift action_86
action_124 (82) = happyShift action_87
action_124 (84) = happyShift action_88
action_124 (85) = happyShift action_89
action_124 (86) = happyShift action_90
action_124 (87) = happyShift action_91
action_124 (88) = happyShift action_92
action_124 (89) = happyShift action_93
action_124 (90) = happyShift action_94
action_124 (91) = happyShift action_95
action_124 (92) = happyShift action_96
action_124 (93) = happyShift action_97
action_124 _ = happyFail (happyExpListPerState 124)

action_125 (23) = happyShift action_16
action_125 (24) = happyShift action_17
action_125 (30) = happyShift action_23
action_125 (37) = happyShift action_26
action_125 (38) = happyShift action_27
action_125 (39) = happyShift action_28
action_125 (40) = happyShift action_29
action_125 (45) = happyShift action_30
action_125 (57) = happyShift action_50
action_125 (59) = happyShift action_51
action_125 (61) = happyShift action_39
action_125 (72) = happyShift action_41
action_125 (95) = happyShift action_42
action_125 (96) = happyShift action_43
action_125 (97) = happyShift action_44
action_125 (98) = happyShift action_45
action_125 (99) = happyShift action_46
action_125 (100) = happyShift action_47
action_125 (13) = happyGoto action_48
action_125 (14) = happyGoto action_186
action_125 (16) = happyGoto action_13
action_125 _ = happyFail (happyExpListPerState 125)

action_126 (58) = happyShift action_185
action_126 _ = happyFail (happyExpListPerState 126)

action_127 _ = happyReduce_103

action_128 (70) = happyShift action_81
action_128 (72) = happyShift action_82
action_128 (74) = happyShift action_83
action_128 (76) = happyShift action_84
action_128 (78) = happyShift action_85
action_128 (80) = happyShift action_86
action_128 (82) = happyShift action_87
action_128 (84) = happyFail []
action_128 (85) = happyFail []
action_128 (86) = happyFail []
action_128 (87) = happyFail []
action_128 (88) = happyShift action_92
action_128 (89) = happyShift action_93
action_128 (90) = happyShift action_94
action_128 (91) = happyShift action_95
action_128 (92) = happyFail []
action_128 (93) = happyFail []
action_128 _ = happyReduce_76

action_129 (70) = happyShift action_81
action_129 (72) = happyShift action_82
action_129 (74) = happyShift action_83
action_129 (76) = happyShift action_84
action_129 (78) = happyShift action_85
action_129 (80) = happyShift action_86
action_129 (82) = happyShift action_87
action_129 (84) = happyFail []
action_129 (85) = happyFail []
action_129 (86) = happyFail []
action_129 (87) = happyFail []
action_129 (88) = happyShift action_92
action_129 (89) = happyShift action_93
action_129 (90) = happyShift action_94
action_129 (91) = happyShift action_95
action_129 (92) = happyFail []
action_129 (93) = happyFail []
action_129 _ = happyReduce_75

action_130 (70) = happyShift action_81
action_130 (72) = happyShift action_82
action_130 (74) = happyShift action_83
action_130 (76) = happyShift action_84
action_130 (78) = happyShift action_85
action_130 (80) = happyShift action_86
action_130 (82) = happyShift action_87
action_130 _ = happyReduce_86

action_131 (70) = happyShift action_81
action_131 (72) = happyShift action_82
action_131 (74) = happyShift action_83
action_131 (76) = happyShift action_84
action_131 (78) = happyShift action_85
action_131 (80) = happyShift action_86
action_131 (82) = happyShift action_87
action_131 _ = happyReduce_85

action_132 (70) = happyShift action_81
action_132 (72) = happyShift action_82
action_132 (74) = happyShift action_83
action_132 (76) = happyShift action_84
action_132 (78) = happyShift action_85
action_132 (80) = happyShift action_86
action_132 (82) = happyShift action_87
action_132 _ = happyReduce_84

action_133 (70) = happyShift action_81
action_133 (72) = happyShift action_82
action_133 (74) = happyShift action_83
action_133 (76) = happyShift action_84
action_133 (78) = happyShift action_85
action_133 (80) = happyShift action_86
action_133 (82) = happyShift action_87
action_133 _ = happyReduce_83

action_134 (70) = happyShift action_81
action_134 (72) = happyShift action_82
action_134 (74) = happyShift action_83
action_134 (76) = happyShift action_84
action_134 (78) = happyShift action_85
action_134 (80) = happyShift action_86
action_134 (82) = happyShift action_87
action_134 (84) = happyFail []
action_134 (85) = happyFail []
action_134 (86) = happyFail []
action_134 (87) = happyFail []
action_134 (88) = happyShift action_92
action_134 (89) = happyShift action_93
action_134 (90) = happyShift action_94
action_134 (91) = happyShift action_95
action_134 (92) = happyFail []
action_134 (93) = happyFail []
action_134 _ = happyReduce_79

action_135 (70) = happyShift action_81
action_135 (72) = happyShift action_82
action_135 (74) = happyShift action_83
action_135 (76) = happyShift action_84
action_135 (78) = happyShift action_85
action_135 (80) = happyShift action_86
action_135 (82) = happyShift action_87
action_135 (84) = happyFail []
action_135 (85) = happyFail []
action_135 (86) = happyFail []
action_135 (87) = happyFail []
action_135 (88) = happyShift action_92
action_135 (89) = happyShift action_93
action_135 (90) = happyShift action_94
action_135 (91) = happyShift action_95
action_135 (92) = happyFail []
action_135 (93) = happyFail []
action_135 _ = happyReduce_80

action_136 (70) = happyShift action_81
action_136 (72) = happyShift action_82
action_136 (74) = happyShift action_83
action_136 (76) = happyShift action_84
action_136 (78) = happyShift action_85
action_136 (80) = happyShift action_86
action_136 (82) = happyShift action_87
action_136 (84) = happyFail []
action_136 (85) = happyFail []
action_136 (86) = happyFail []
action_136 (87) = happyFail []
action_136 (88) = happyShift action_92
action_136 (89) = happyShift action_93
action_136 (90) = happyShift action_94
action_136 (91) = happyShift action_95
action_136 (92) = happyFail []
action_136 (93) = happyFail []
action_136 _ = happyReduce_77

action_137 (70) = happyShift action_81
action_137 (72) = happyShift action_82
action_137 (74) = happyShift action_83
action_137 (76) = happyShift action_84
action_137 (78) = happyShift action_85
action_137 (80) = happyShift action_86
action_137 (82) = happyShift action_87
action_137 (84) = happyFail []
action_137 (85) = happyFail []
action_137 (86) = happyFail []
action_137 (87) = happyFail []
action_137 (88) = happyShift action_92
action_137 (89) = happyShift action_93
action_137 (90) = happyShift action_94
action_137 (91) = happyShift action_95
action_137 (92) = happyFail []
action_137 (93) = happyFail []
action_137 _ = happyReduce_78

action_138 (76) = happyShift action_84
action_138 _ = happyReduce_72

action_139 (76) = happyShift action_84
action_139 _ = happyReduce_70

action_140 (76) = happyShift action_84
action_140 _ = happyReduce_71

action_141 (76) = happyFail []
action_141 _ = happyReduce_73

action_142 (76) = happyShift action_84
action_142 _ = happyReduce_69

action_143 (74) = happyShift action_83
action_143 (76) = happyShift action_84
action_143 (78) = happyShift action_85
action_143 (80) = happyShift action_86
action_143 (82) = happyShift action_87
action_143 _ = happyReduce_68

action_144 (74) = happyShift action_83
action_144 (76) = happyShift action_84
action_144 (78) = happyShift action_85
action_144 (80) = happyShift action_86
action_144 (82) = happyShift action_87
action_144 _ = happyReduce_67

action_145 (58) = happyShift action_184
action_145 (70) = happyShift action_81
action_145 (72) = happyShift action_82
action_145 (74) = happyShift action_83
action_145 (76) = happyShift action_84
action_145 (78) = happyShift action_85
action_145 (80) = happyShift action_86
action_145 (82) = happyShift action_87
action_145 (84) = happyShift action_88
action_145 (85) = happyShift action_89
action_145 (86) = happyShift action_90
action_145 (87) = happyShift action_91
action_145 (88) = happyShift action_92
action_145 (89) = happyShift action_93
action_145 (90) = happyShift action_94
action_145 (91) = happyShift action_95
action_145 (92) = happyShift action_96
action_145 (93) = happyShift action_97
action_145 _ = happyFail (happyExpListPerState 145)

action_146 (58) = happyShift action_183
action_146 (70) = happyShift action_81
action_146 (72) = happyShift action_82
action_146 (74) = happyShift action_83
action_146 (76) = happyShift action_84
action_146 (78) = happyShift action_85
action_146 (80) = happyShift action_86
action_146 (82) = happyShift action_87
action_146 (84) = happyShift action_88
action_146 (85) = happyShift action_89
action_146 (86) = happyShift action_90
action_146 (87) = happyShift action_91
action_146 (88) = happyShift action_92
action_146 (89) = happyShift action_93
action_146 (90) = happyShift action_94
action_146 (91) = happyShift action_95
action_146 (92) = happyShift action_96
action_146 (93) = happyShift action_97
action_146 _ = happyFail (happyExpListPerState 146)

action_147 (58) = happyShift action_182
action_147 _ = happyFail (happyExpListPerState 147)

action_148 _ = happyReduce_60

action_149 (58) = happyShift action_181
action_149 (70) = happyShift action_81
action_149 (72) = happyShift action_82
action_149 (74) = happyShift action_83
action_149 (76) = happyShift action_84
action_149 (78) = happyShift action_85
action_149 (80) = happyShift action_86
action_149 (82) = happyShift action_87
action_149 (84) = happyShift action_88
action_149 (85) = happyShift action_89
action_149 (86) = happyShift action_90
action_149 (87) = happyShift action_91
action_149 (88) = happyShift action_92
action_149 (89) = happyShift action_93
action_149 (90) = happyShift action_94
action_149 (91) = happyShift action_95
action_149 (92) = happyShift action_96
action_149 (93) = happyShift action_97
action_149 _ = happyFail (happyExpListPerState 149)

action_150 _ = happyReduce_61

action_151 (58) = happyShift action_180
action_151 (70) = happyShift action_81
action_151 (72) = happyShift action_82
action_151 (74) = happyShift action_83
action_151 (76) = happyShift action_84
action_151 (78) = happyShift action_85
action_151 (80) = happyShift action_86
action_151 (82) = happyShift action_87
action_151 (84) = happyShift action_88
action_151 (85) = happyShift action_89
action_151 (86) = happyShift action_90
action_151 (87) = happyShift action_91
action_151 (88) = happyShift action_92
action_151 (89) = happyShift action_93
action_151 (90) = happyShift action_94
action_151 (91) = happyShift action_95
action_151 (92) = happyShift action_96
action_151 (93) = happyShift action_97
action_151 _ = happyFail (happyExpListPerState 151)

action_152 (58) = happyShift action_179
action_152 (70) = happyShift action_81
action_152 (72) = happyShift action_82
action_152 (74) = happyShift action_83
action_152 (76) = happyShift action_84
action_152 (78) = happyShift action_85
action_152 (80) = happyShift action_86
action_152 (82) = happyShift action_87
action_152 (84) = happyShift action_88
action_152 (85) = happyShift action_89
action_152 (86) = happyShift action_90
action_152 (87) = happyShift action_91
action_152 (88) = happyShift action_92
action_152 (89) = happyShift action_93
action_152 (90) = happyShift action_94
action_152 (91) = happyShift action_95
action_152 (92) = happyShift action_96
action_152 (93) = happyShift action_97
action_152 _ = happyFail (happyExpListPerState 152)

action_153 (23) = happyShift action_16
action_153 (24) = happyShift action_17
action_153 (30) = happyShift action_23
action_153 (37) = happyShift action_26
action_153 (38) = happyShift action_27
action_153 (39) = happyShift action_28
action_153 (40) = happyShift action_29
action_153 (42) = happyShift action_178
action_153 (45) = happyShift action_30
action_153 (57) = happyShift action_50
action_153 (59) = happyShift action_51
action_153 (61) = happyShift action_39
action_153 (72) = happyShift action_41
action_153 (95) = happyShift action_42
action_153 (96) = happyShift action_43
action_153 (97) = happyShift action_44
action_153 (98) = happyShift action_45
action_153 (99) = happyShift action_46
action_153 (100) = happyShift action_47
action_153 (13) = happyGoto action_48
action_153 (14) = happyGoto action_177
action_153 (16) = happyGoto action_13
action_153 _ = happyFail (happyExpListPerState 153)

action_154 (66) = happyShift action_176
action_154 _ = happyFail (happyExpListPerState 154)

action_155 (23) = happyShift action_16
action_155 (24) = happyShift action_17
action_155 (30) = happyShift action_23
action_155 (37) = happyShift action_26
action_155 (38) = happyShift action_27
action_155 (39) = happyShift action_28
action_155 (40) = happyShift action_29
action_155 (45) = happyShift action_30
action_155 (57) = happyShift action_50
action_155 (59) = happyShift action_51
action_155 (61) = happyShift action_39
action_155 (72) = happyShift action_41
action_155 (95) = happyShift action_42
action_155 (96) = happyShift action_43
action_155 (97) = happyShift action_44
action_155 (98) = happyShift action_45
action_155 (99) = happyShift action_46
action_155 (100) = happyShift action_47
action_155 (13) = happyGoto action_48
action_155 (14) = happyGoto action_175
action_155 (16) = happyGoto action_13
action_155 _ = happyFail (happyExpListPerState 155)

action_156 (23) = happyShift action_16
action_156 (24) = happyShift action_17
action_156 (30) = happyShift action_23
action_156 (37) = happyShift action_26
action_156 (38) = happyShift action_27
action_156 (39) = happyShift action_28
action_156 (40) = happyShift action_29
action_156 (45) = happyShift action_30
action_156 (57) = happyShift action_50
action_156 (59) = happyShift action_51
action_156 (61) = happyShift action_39
action_156 (72) = happyShift action_41
action_156 (95) = happyShift action_42
action_156 (96) = happyShift action_43
action_156 (97) = happyShift action_44
action_156 (98) = happyShift action_45
action_156 (99) = happyShift action_46
action_156 (100) = happyShift action_47
action_156 (13) = happyGoto action_48
action_156 (14) = happyGoto action_174
action_156 (16) = happyGoto action_13
action_156 _ = happyFail (happyExpListPerState 156)

action_157 _ = happyReduce_57

action_158 (22) = happyShift action_15
action_158 (25) = happyShift action_18
action_158 (26) = happyShift action_19
action_158 (27) = happyShift action_20
action_158 (28) = happyShift action_21
action_158 (29) = happyShift action_22
action_158 (33) = happyShift action_24
action_158 (34) = happyShift action_25
action_158 (57) = happyShift action_54
action_158 (59) = happyShift action_55
action_158 (68) = happyShift action_40
action_158 (10) = happyGoto action_173
action_158 (12) = happyGoto action_10
action_158 _ = happyFail (happyExpListPerState 158)

action_159 (22) = happyShift action_15
action_159 (25) = happyShift action_18
action_159 (26) = happyShift action_19
action_159 (27) = happyShift action_20
action_159 (28) = happyShift action_21
action_159 (29) = happyShift action_22
action_159 (33) = happyShift action_24
action_159 (34) = happyShift action_25
action_159 (57) = happyShift action_54
action_159 (59) = happyShift action_55
action_159 (68) = happyShift action_40
action_159 (10) = happyGoto action_62
action_159 (11) = happyGoto action_172
action_159 (12) = happyGoto action_10
action_159 _ = happyFail (happyExpListPerState 159)

action_160 _ = happyReduce_90

action_161 (23) = happyShift action_16
action_161 (24) = happyShift action_17
action_161 (30) = happyShift action_23
action_161 (37) = happyShift action_26
action_161 (38) = happyShift action_27
action_161 (39) = happyShift action_28
action_161 (40) = happyShift action_29
action_161 (45) = happyShift action_30
action_161 (57) = happyShift action_50
action_161 (59) = happyShift action_51
action_161 (61) = happyShift action_39
action_161 (72) = happyShift action_41
action_161 (95) = happyShift action_42
action_161 (96) = happyShift action_43
action_161 (97) = happyShift action_44
action_161 (98) = happyShift action_45
action_161 (99) = happyShift action_46
action_161 (100) = happyShift action_47
action_161 (13) = happyGoto action_48
action_161 (14) = happyGoto action_60
action_161 (16) = happyGoto action_13
action_161 (17) = happyGoto action_171
action_161 _ = happyFail (happyExpListPerState 161)

action_162 (30) = happyShift action_167
action_162 (31) = happyShift action_168
action_162 (32) = happyShift action_169
action_162 (36) = happyShift action_170
action_162 _ = happyFail (happyExpListPerState 162)

action_163 _ = happyReduce_93

action_164 _ = happyReduce_91

action_165 (23) = happyShift action_16
action_165 (24) = happyShift action_17
action_165 (30) = happyShift action_23
action_165 (37) = happyShift action_26
action_165 (38) = happyShift action_27
action_165 (39) = happyShift action_28
action_165 (40) = happyShift action_29
action_165 (45) = happyShift action_30
action_165 (57) = happyShift action_50
action_165 (59) = happyShift action_51
action_165 (61) = happyShift action_39
action_165 (72) = happyShift action_41
action_165 (95) = happyShift action_42
action_165 (96) = happyShift action_43
action_165 (97) = happyShift action_44
action_165 (98) = happyShift action_45
action_165 (99) = happyShift action_46
action_165 (100) = happyShift action_47
action_165 (13) = happyGoto action_48
action_165 (14) = happyGoto action_166
action_165 (16) = happyGoto action_13
action_165 _ = happyFail (happyExpListPerState 165)

action_166 (65) = happyShift action_203
action_166 (70) = happyShift action_81
action_166 (72) = happyShift action_82
action_166 (74) = happyShift action_83
action_166 (76) = happyShift action_84
action_166 (78) = happyShift action_85
action_166 (80) = happyShift action_86
action_166 (82) = happyShift action_87
action_166 (84) = happyShift action_88
action_166 (85) = happyShift action_89
action_166 (86) = happyShift action_90
action_166 (87) = happyShift action_91
action_166 (88) = happyShift action_92
action_166 (89) = happyShift action_93
action_166 (90) = happyShift action_94
action_166 (91) = happyShift action_95
action_166 (92) = happyShift action_96
action_166 (93) = happyShift action_97
action_166 _ = happyReduce_107

action_167 _ = happyReduce_46

action_168 _ = happyReduce_47

action_169 _ = happyReduce_48

action_170 _ = happyReduce_49

action_171 _ = happyReduce_104

action_172 _ = happyReduce_45

action_173 (58) = happyShift action_202
action_173 _ = happyFail (happyExpListPerState 173)

action_174 (58) = happyShift action_201
action_174 (70) = happyShift action_81
action_174 (72) = happyShift action_82
action_174 (74) = happyShift action_83
action_174 (76) = happyShift action_84
action_174 (78) = happyShift action_85
action_174 (80) = happyShift action_86
action_174 (82) = happyShift action_87
action_174 (84) = happyShift action_88
action_174 (85) = happyShift action_89
action_174 (86) = happyShift action_90
action_174 (87) = happyShift action_91
action_174 (88) = happyShift action_92
action_174 (89) = happyShift action_93
action_174 (90) = happyShift action_94
action_174 (91) = happyShift action_95
action_174 (92) = happyShift action_96
action_174 (93) = happyShift action_97
action_174 _ = happyFail (happyExpListPerState 174)

action_175 (58) = happyShift action_200
action_175 (70) = happyShift action_81
action_175 (72) = happyShift action_82
action_175 (74) = happyShift action_83
action_175 (76) = happyShift action_84
action_175 (78) = happyShift action_85
action_175 (80) = happyShift action_86
action_175 (82) = happyShift action_87
action_175 (84) = happyShift action_88
action_175 (85) = happyShift action_89
action_175 (86) = happyShift action_90
action_175 (87) = happyShift action_91
action_175 (88) = happyShift action_92
action_175 (89) = happyShift action_93
action_175 (90) = happyShift action_94
action_175 (91) = happyShift action_95
action_175 (92) = happyShift action_96
action_175 (93) = happyShift action_97
action_175 _ = happyFail (happyExpListPerState 175)

action_176 (23) = happyShift action_16
action_176 (24) = happyShift action_17
action_176 (30) = happyShift action_23
action_176 (37) = happyShift action_26
action_176 (38) = happyShift action_27
action_176 (39) = happyShift action_28
action_176 (40) = happyShift action_29
action_176 (45) = happyShift action_30
action_176 (57) = happyShift action_50
action_176 (59) = happyShift action_51
action_176 (61) = happyShift action_39
action_176 (72) = happyShift action_41
action_176 (95) = happyShift action_42
action_176 (96) = happyShift action_43
action_176 (97) = happyShift action_44
action_176 (98) = happyShift action_45
action_176 (99) = happyShift action_46
action_176 (100) = happyShift action_47
action_176 (13) = happyGoto action_48
action_176 (14) = happyGoto action_199
action_176 (16) = happyGoto action_13
action_176 _ = happyFail (happyExpListPerState 176)

action_177 (61) = happyShift action_198
action_177 (70) = happyShift action_81
action_177 (72) = happyShift action_82
action_177 (74) = happyShift action_83
action_177 (76) = happyShift action_84
action_177 (78) = happyShift action_85
action_177 (80) = happyShift action_86
action_177 (82) = happyShift action_87
action_177 (84) = happyShift action_88
action_177 (85) = happyShift action_89
action_177 (86) = happyShift action_90
action_177 (87) = happyShift action_91
action_177 (88) = happyShift action_92
action_177 (89) = happyShift action_93
action_177 (90) = happyShift action_94
action_177 (91) = happyShift action_95
action_177 (92) = happyShift action_96
action_177 (93) = happyShift action_97
action_177 _ = happyFail (happyExpListPerState 177)

action_178 (57) = happyShift action_197
action_178 _ = happyFail (happyExpListPerState 178)

action_179 (61) = happyShift action_196
action_179 _ = happyFail (happyExpListPerState 179)

action_180 (61) = happyShift action_195
action_180 _ = happyFail (happyExpListPerState 180)

action_181 _ = happyReduce_62

action_182 _ = happyReduce_59

action_183 _ = happyReduce_63

action_184 (22) = happyShift action_15
action_184 (25) = happyShift action_18
action_184 (26) = happyShift action_19
action_184 (27) = happyShift action_20
action_184 (28) = happyShift action_21
action_184 (29) = happyShift action_22
action_184 (33) = happyShift action_24
action_184 (34) = happyShift action_25
action_184 (57) = happyShift action_54
action_184 (59) = happyShift action_55
action_184 (68) = happyShift action_40
action_184 (10) = happyGoto action_194
action_184 (12) = happyGoto action_10
action_184 _ = happyFail (happyExpListPerState 184)

action_185 _ = happyReduce_102

action_186 (60) = happyShift action_193
action_186 (70) = happyShift action_81
action_186 (72) = happyShift action_82
action_186 (74) = happyShift action_83
action_186 (76) = happyShift action_84
action_186 (78) = happyShift action_85
action_186 (80) = happyShift action_86
action_186 (82) = happyShift action_87
action_186 (84) = happyShift action_88
action_186 (85) = happyShift action_89
action_186 (86) = happyShift action_90
action_186 (87) = happyShift action_91
action_186 (88) = happyShift action_92
action_186 (89) = happyShift action_93
action_186 (90) = happyShift action_94
action_186 (91) = happyShift action_95
action_186 (92) = happyShift action_96
action_186 (93) = happyShift action_97
action_186 _ = happyFail (happyExpListPerState 186)

action_187 (59) = happyFail []
action_187 (15) = happyGoto action_192
action_187 _ = happyReduce_94

action_188 (23) = happyShift action_16
action_188 (24) = happyShift action_17
action_188 (30) = happyShift action_23
action_188 (37) = happyShift action_26
action_188 (38) = happyShift action_27
action_188 (39) = happyShift action_28
action_188 (40) = happyShift action_29
action_188 (45) = happyShift action_30
action_188 (57) = happyShift action_50
action_188 (59) = happyShift action_51
action_188 (60) = happyShift action_191
action_188 (61) = happyShift action_39
action_188 (72) = happyShift action_41
action_188 (95) = happyShift action_42
action_188 (96) = happyShift action_43
action_188 (97) = happyShift action_44
action_188 (98) = happyShift action_45
action_188 (99) = happyShift action_46
action_188 (100) = happyShift action_47
action_188 (13) = happyGoto action_48
action_188 (14) = happyGoto action_190
action_188 (16) = happyGoto action_13
action_188 _ = happyFail (happyExpListPerState 188)

action_189 (70) = happyShift action_81
action_189 (72) = happyShift action_82
action_189 (74) = happyShift action_83
action_189 (76) = happyShift action_84
action_189 (78) = happyShift action_85
action_189 (80) = happyShift action_86
action_189 (82) = happyShift action_87
action_189 (84) = happyShift action_88
action_189 (85) = happyShift action_89
action_189 (86) = happyShift action_90
action_189 (87) = happyShift action_91
action_189 (88) = happyShift action_92
action_189 (89) = happyShift action_93
action_189 (90) = happyShift action_94
action_189 (91) = happyShift action_95
action_189 (92) = happyShift action_96
action_189 (93) = happyShift action_97
action_189 _ = happyReduce_7

action_190 (60) = happyShift action_215
action_190 (70) = happyShift action_81
action_190 (72) = happyShift action_82
action_190 (74) = happyShift action_83
action_190 (76) = happyShift action_84
action_190 (78) = happyShift action_85
action_190 (80) = happyShift action_86
action_190 (82) = happyShift action_87
action_190 (84) = happyShift action_88
action_190 (85) = happyShift action_89
action_190 (86) = happyShift action_90
action_190 (87) = happyShift action_91
action_190 (88) = happyShift action_92
action_190 (89) = happyShift action_93
action_190 (90) = happyShift action_94
action_190 (91) = happyShift action_95
action_190 (92) = happyShift action_96
action_190 (93) = happyShift action_97
action_190 _ = happyFail (happyExpListPerState 190)

action_191 (59) = happyFail []
action_191 (15) = happyGoto action_214
action_191 _ = happyReduce_100

action_192 _ = happyReduce_95

action_193 (59) = happyFail []
action_193 (15) = happyGoto action_213
action_193 _ = happyReduce_98

action_194 _ = happyReduce_92

action_195 (22) = happyShift action_15
action_195 (23) = happyShift action_16
action_195 (24) = happyShift action_17
action_195 (25) = happyShift action_18
action_195 (26) = happyShift action_19
action_195 (27) = happyShift action_20
action_195 (28) = happyShift action_21
action_195 (29) = happyShift action_22
action_195 (30) = happyShift action_23
action_195 (33) = happyShift action_24
action_195 (34) = happyShift action_25
action_195 (37) = happyShift action_26
action_195 (38) = happyShift action_27
action_195 (39) = happyShift action_28
action_195 (40) = happyShift action_29
action_195 (45) = happyShift action_30
action_195 (46) = happyShift action_31
action_195 (49) = happyShift action_32
action_195 (52) = happyShift action_33
action_195 (53) = happyShift action_34
action_195 (54) = happyShift action_35
action_195 (55) = happyShift action_36
action_195 (57) = happyShift action_37
action_195 (59) = happyShift action_38
action_195 (61) = happyShift action_39
action_195 (68) = happyShift action_40
action_195 (72) = happyShift action_41
action_195 (95) = happyShift action_42
action_195 (96) = happyShift action_43
action_195 (97) = happyShift action_44
action_195 (98) = happyShift action_45
action_195 (99) = happyShift action_46
action_195 (100) = happyShift action_47
action_195 (5) = happyGoto action_212
action_195 (6) = happyGoto action_6
action_195 (7) = happyGoto action_7
action_195 (9) = happyGoto action_8
action_195 (10) = happyGoto action_9
action_195 (12) = happyGoto action_10
action_195 (13) = happyGoto action_11
action_195 (14) = happyGoto action_12
action_195 (16) = happyGoto action_13
action_195 _ = happyFail (happyExpListPerState 195)

action_196 (22) = happyShift action_15
action_196 (23) = happyShift action_16
action_196 (24) = happyShift action_17
action_196 (25) = happyShift action_18
action_196 (26) = happyShift action_19
action_196 (27) = happyShift action_20
action_196 (28) = happyShift action_21
action_196 (29) = happyShift action_22
action_196 (30) = happyShift action_23
action_196 (33) = happyShift action_24
action_196 (34) = happyShift action_25
action_196 (37) = happyShift action_26
action_196 (38) = happyShift action_27
action_196 (39) = happyShift action_28
action_196 (40) = happyShift action_29
action_196 (45) = happyShift action_30
action_196 (46) = happyShift action_31
action_196 (49) = happyShift action_32
action_196 (52) = happyShift action_33
action_196 (53) = happyShift action_34
action_196 (54) = happyShift action_35
action_196 (55) = happyShift action_36
action_196 (57) = happyShift action_37
action_196 (59) = happyShift action_38
action_196 (61) = happyShift action_39
action_196 (68) = happyShift action_40
action_196 (72) = happyShift action_41
action_196 (95) = happyShift action_42
action_196 (96) = happyShift action_43
action_196 (97) = happyShift action_44
action_196 (98) = happyShift action_45
action_196 (99) = happyShift action_46
action_196 (100) = happyShift action_47
action_196 (5) = happyGoto action_211
action_196 (6) = happyGoto action_6
action_196 (7) = happyGoto action_7
action_196 (9) = happyGoto action_8
action_196 (10) = happyGoto action_9
action_196 (12) = happyGoto action_10
action_196 (13) = happyGoto action_11
action_196 (14) = happyGoto action_12
action_196 (16) = happyGoto action_13
action_196 _ = happyFail (happyExpListPerState 196)

action_197 (23) = happyShift action_16
action_197 (24) = happyShift action_17
action_197 (30) = happyShift action_23
action_197 (37) = happyShift action_26
action_197 (38) = happyShift action_27
action_197 (39) = happyShift action_28
action_197 (40) = happyShift action_29
action_197 (45) = happyShift action_30
action_197 (57) = happyShift action_50
action_197 (59) = happyShift action_51
action_197 (61) = happyShift action_39
action_197 (72) = happyShift action_41
action_197 (95) = happyShift action_42
action_197 (96) = happyShift action_43
action_197 (97) = happyShift action_44
action_197 (98) = happyShift action_45
action_197 (99) = happyShift action_46
action_197 (100) = happyShift action_47
action_197 (13) = happyGoto action_48
action_197 (14) = happyGoto action_210
action_197 (16) = happyGoto action_13
action_197 _ = happyFail (happyExpListPerState 197)

action_198 (22) = happyShift action_15
action_198 (23) = happyShift action_16
action_198 (24) = happyShift action_17
action_198 (25) = happyShift action_18
action_198 (26) = happyShift action_19
action_198 (27) = happyShift action_20
action_198 (28) = happyShift action_21
action_198 (29) = happyShift action_22
action_198 (30) = happyShift action_23
action_198 (33) = happyShift action_24
action_198 (34) = happyShift action_25
action_198 (37) = happyShift action_26
action_198 (38) = happyShift action_27
action_198 (39) = happyShift action_28
action_198 (40) = happyShift action_29
action_198 (45) = happyShift action_30
action_198 (46) = happyShift action_31
action_198 (49) = happyShift action_32
action_198 (52) = happyShift action_33
action_198 (53) = happyShift action_34
action_198 (54) = happyShift action_35
action_198 (55) = happyShift action_36
action_198 (57) = happyShift action_37
action_198 (59) = happyShift action_38
action_198 (61) = happyShift action_39
action_198 (68) = happyShift action_40
action_198 (72) = happyShift action_41
action_198 (95) = happyShift action_42
action_198 (96) = happyShift action_43
action_198 (97) = happyShift action_44
action_198 (98) = happyShift action_45
action_198 (99) = happyShift action_46
action_198 (100) = happyShift action_47
action_198 (5) = happyGoto action_209
action_198 (6) = happyGoto action_6
action_198 (7) = happyGoto action_7
action_198 (9) = happyGoto action_8
action_198 (10) = happyGoto action_9
action_198 (12) = happyGoto action_10
action_198 (13) = happyGoto action_11
action_198 (14) = happyGoto action_12
action_198 (16) = happyGoto action_13
action_198 _ = happyFail (happyExpListPerState 198)

action_199 (66) = happyShift action_208
action_199 (70) = happyShift action_81
action_199 (72) = happyShift action_82
action_199 (74) = happyShift action_83
action_199 (76) = happyShift action_84
action_199 (78) = happyShift action_85
action_199 (80) = happyShift action_86
action_199 (82) = happyShift action_87
action_199 (84) = happyShift action_88
action_199 (85) = happyShift action_89
action_199 (86) = happyShift action_90
action_199 (87) = happyShift action_91
action_199 (88) = happyShift action_92
action_199 (89) = happyShift action_93
action_199 (90) = happyShift action_94
action_199 (91) = happyShift action_95
action_199 (92) = happyShift action_96
action_199 (93) = happyShift action_97
action_199 _ = happyFail (happyExpListPerState 199)

action_200 (61) = happyShift action_207
action_200 _ = happyFail (happyExpListPerState 200)

action_201 (61) = happyShift action_206
action_201 _ = happyFail (happyExpListPerState 201)

action_202 _ = happyReduce_53

action_203 (23) = happyShift action_16
action_203 (24) = happyShift action_17
action_203 (30) = happyShift action_23
action_203 (37) = happyShift action_26
action_203 (38) = happyShift action_27
action_203 (39) = happyShift action_28
action_203 (40) = happyShift action_29
action_203 (45) = happyShift action_30
action_203 (57) = happyShift action_50
action_203 (59) = happyShift action_51
action_203 (61) = happyShift action_39
action_203 (72) = happyShift action_41
action_203 (95) = happyShift action_42
action_203 (96) = happyShift action_43
action_203 (97) = happyShift action_44
action_203 (98) = happyShift action_45
action_203 (99) = happyShift action_46
action_203 (100) = happyShift action_47
action_203 (13) = happyGoto action_48
action_203 (14) = happyGoto action_204
action_203 (16) = happyGoto action_13
action_203 (18) = happyGoto action_205
action_203 _ = happyFail (happyExpListPerState 203)

action_204 (67) = happyShift action_165
action_204 (70) = happyShift action_81
action_204 (72) = happyShift action_82
action_204 (74) = happyShift action_83
action_204 (76) = happyShift action_84
action_204 (78) = happyShift action_85
action_204 (80) = happyShift action_86
action_204 (82) = happyShift action_87
action_204 (84) = happyShift action_88
action_204 (85) = happyShift action_89
action_204 (86) = happyShift action_90
action_204 (87) = happyShift action_91
action_204 (88) = happyShift action_92
action_204 (89) = happyShift action_93
action_204 (90) = happyShift action_94
action_204 (91) = happyShift action_95
action_204 (92) = happyShift action_96
action_204 (93) = happyShift action_97
action_204 _ = happyFail (happyExpListPerState 204)

action_205 _ = happyReduce_106

action_206 (22) = happyShift action_15
action_206 (23) = happyShift action_16
action_206 (24) = happyShift action_17
action_206 (25) = happyShift action_18
action_206 (26) = happyShift action_19
action_206 (27) = happyShift action_20
action_206 (28) = happyShift action_21
action_206 (29) = happyShift action_22
action_206 (30) = happyShift action_23
action_206 (33) = happyShift action_24
action_206 (34) = happyShift action_25
action_206 (37) = happyShift action_26
action_206 (38) = happyShift action_27
action_206 (39) = happyShift action_28
action_206 (40) = happyShift action_29
action_206 (45) = happyShift action_30
action_206 (46) = happyShift action_31
action_206 (49) = happyShift action_32
action_206 (52) = happyShift action_33
action_206 (53) = happyShift action_34
action_206 (54) = happyShift action_35
action_206 (55) = happyShift action_36
action_206 (57) = happyShift action_37
action_206 (59) = happyShift action_38
action_206 (61) = happyShift action_39
action_206 (68) = happyShift action_40
action_206 (72) = happyShift action_41
action_206 (95) = happyShift action_42
action_206 (96) = happyShift action_43
action_206 (97) = happyShift action_44
action_206 (98) = happyShift action_45
action_206 (99) = happyShift action_46
action_206 (100) = happyShift action_47
action_206 (5) = happyGoto action_224
action_206 (6) = happyGoto action_6
action_206 (7) = happyGoto action_7
action_206 (9) = happyGoto action_8
action_206 (10) = happyGoto action_9
action_206 (12) = happyGoto action_10
action_206 (13) = happyGoto action_11
action_206 (14) = happyGoto action_12
action_206 (16) = happyGoto action_13
action_206 _ = happyFail (happyExpListPerState 206)

action_207 (22) = happyShift action_15
action_207 (23) = happyShift action_16
action_207 (24) = happyShift action_17
action_207 (25) = happyShift action_18
action_207 (26) = happyShift action_19
action_207 (27) = happyShift action_20
action_207 (28) = happyShift action_21
action_207 (29) = happyShift action_22
action_207 (30) = happyShift action_23
action_207 (33) = happyShift action_24
action_207 (34) = happyShift action_25
action_207 (37) = happyShift action_26
action_207 (38) = happyShift action_27
action_207 (39) = happyShift action_28
action_207 (40) = happyShift action_29
action_207 (45) = happyShift action_30
action_207 (46) = happyShift action_31
action_207 (49) = happyShift action_32
action_207 (52) = happyShift action_33
action_207 (53) = happyShift action_34
action_207 (54) = happyShift action_35
action_207 (55) = happyShift action_36
action_207 (57) = happyShift action_37
action_207 (59) = happyShift action_38
action_207 (61) = happyShift action_39
action_207 (68) = happyShift action_40
action_207 (72) = happyShift action_41
action_207 (95) = happyShift action_42
action_207 (96) = happyShift action_43
action_207 (97) = happyShift action_44
action_207 (98) = happyShift action_45
action_207 (99) = happyShift action_46
action_207 (100) = happyShift action_47
action_207 (5) = happyGoto action_223
action_207 (6) = happyGoto action_6
action_207 (7) = happyGoto action_7
action_207 (9) = happyGoto action_8
action_207 (10) = happyGoto action_9
action_207 (12) = happyGoto action_10
action_207 (13) = happyGoto action_11
action_207 (14) = happyGoto action_12
action_207 (16) = happyGoto action_13
action_207 _ = happyFail (happyExpListPerState 207)

action_208 (22) = happyShift action_15
action_208 (23) = happyShift action_16
action_208 (24) = happyShift action_17
action_208 (25) = happyShift action_18
action_208 (26) = happyShift action_19
action_208 (27) = happyShift action_20
action_208 (28) = happyShift action_21
action_208 (29) = happyShift action_22
action_208 (30) = happyShift action_23
action_208 (33) = happyShift action_24
action_208 (34) = happyShift action_25
action_208 (37) = happyShift action_26
action_208 (38) = happyShift action_27
action_208 (39) = happyShift action_28
action_208 (40) = happyShift action_29
action_208 (45) = happyShift action_30
action_208 (46) = happyShift action_31
action_208 (49) = happyShift action_32
action_208 (52) = happyShift action_33
action_208 (53) = happyShift action_34
action_208 (54) = happyShift action_35
action_208 (55) = happyShift action_36
action_208 (57) = happyShift action_37
action_208 (59) = happyShift action_38
action_208 (61) = happyShift action_39
action_208 (68) = happyShift action_40
action_208 (72) = happyShift action_41
action_208 (95) = happyShift action_42
action_208 (96) = happyShift action_43
action_208 (97) = happyShift action_44
action_208 (98) = happyShift action_45
action_208 (99) = happyShift action_46
action_208 (100) = happyShift action_47
action_208 (6) = happyGoto action_222
action_208 (7) = happyGoto action_7
action_208 (9) = happyGoto action_8
action_208 (10) = happyGoto action_9
action_208 (12) = happyGoto action_10
action_208 (13) = happyGoto action_11
action_208 (14) = happyGoto action_12
action_208 (16) = happyGoto action_13
action_208 _ = happyFail (happyExpListPerState 208)

action_209 (62) = happyShift action_221
action_209 _ = happyFail (happyExpListPerState 209)

action_210 (58) = happyShift action_219
action_210 (65) = happyShift action_220
action_210 (70) = happyShift action_81
action_210 (72) = happyShift action_82
action_210 (74) = happyShift action_83
action_210 (76) = happyShift action_84
action_210 (78) = happyShift action_85
action_210 (80) = happyShift action_86
action_210 (82) = happyShift action_87
action_210 (84) = happyShift action_88
action_210 (85) = happyShift action_89
action_210 (86) = happyShift action_90
action_210 (87) = happyShift action_91
action_210 (88) = happyShift action_92
action_210 (89) = happyShift action_93
action_210 (90) = happyShift action_94
action_210 (91) = happyShift action_95
action_210 (92) = happyShift action_96
action_210 (93) = happyShift action_97
action_210 _ = happyFail (happyExpListPerState 210)

action_211 (62) = happyShift action_218
action_211 _ = happyFail (happyExpListPerState 211)

action_212 (62) = happyShift action_217
action_212 _ = happyFail (happyExpListPerState 212)

action_213 _ = happyReduce_99

action_214 _ = happyReduce_101

action_215 (59) = happyFail []
action_215 (15) = happyGoto action_216
action_215 _ = happyReduce_96

action_216 _ = happyReduce_97

action_217 (47) = happyShift action_230
action_217 (48) = happyShift action_231
action_217 (8) = happyGoto action_229
action_217 _ = happyReduce_28

action_218 _ = happyReduce_29

action_219 _ = happyReduce_22

action_220 (23) = happyShift action_16
action_220 (24) = happyShift action_17
action_220 (30) = happyShift action_23
action_220 (37) = happyShift action_26
action_220 (38) = happyShift action_27
action_220 (39) = happyShift action_28
action_220 (40) = happyShift action_29
action_220 (45) = happyShift action_30
action_220 (57) = happyShift action_50
action_220 (59) = happyShift action_51
action_220 (61) = happyShift action_39
action_220 (72) = happyShift action_41
action_220 (95) = happyShift action_42
action_220 (96) = happyShift action_43
action_220 (97) = happyShift action_44
action_220 (98) = happyShift action_45
action_220 (99) = happyShift action_46
action_220 (100) = happyShift action_47
action_220 (13) = happyGoto action_48
action_220 (14) = happyGoto action_228
action_220 (16) = happyGoto action_13
action_220 _ = happyFail (happyExpListPerState 220)

action_221 _ = happyReduce_19

action_222 (58) = happyShift action_227
action_222 _ = happyFail (happyExpListPerState 222)

action_223 (62) = happyShift action_226
action_223 _ = happyFail (happyExpListPerState 223)

action_224 (62) = happyShift action_225
action_224 _ = happyFail (happyExpListPerState 224)

action_225 _ = happyReduce_34

action_226 _ = happyReduce_35

action_227 (61) = happyShift action_236
action_227 _ = happyFail (happyExpListPerState 227)

action_228 (58) = happyShift action_234
action_228 (65) = happyShift action_235
action_228 (70) = happyShift action_81
action_228 (72) = happyShift action_82
action_228 (74) = happyShift action_83
action_228 (76) = happyShift action_84
action_228 (78) = happyShift action_85
action_228 (80) = happyShift action_86
action_228 (82) = happyShift action_87
action_228 (84) = happyShift action_88
action_228 (85) = happyShift action_89
action_228 (86) = happyShift action_90
action_228 (87) = happyShift action_91
action_228 (88) = happyShift action_92
action_228 (89) = happyShift action_93
action_228 (90) = happyShift action_94
action_228 (91) = happyShift action_95
action_228 (92) = happyShift action_96
action_228 (93) = happyShift action_97
action_228 _ = happyFail (happyExpListPerState 228)

action_229 _ = happyReduce_30

action_230 (57) = happyShift action_233
action_230 _ = happyFail (happyExpListPerState 230)

action_231 (61) = happyShift action_232
action_231 _ = happyFail (happyExpListPerState 231)

action_232 (22) = happyShift action_15
action_232 (23) = happyShift action_16
action_232 (24) = happyShift action_17
action_232 (25) = happyShift action_18
action_232 (26) = happyShift action_19
action_232 (27) = happyShift action_20
action_232 (28) = happyShift action_21
action_232 (29) = happyShift action_22
action_232 (30) = happyShift action_23
action_232 (33) = happyShift action_24
action_232 (34) = happyShift action_25
action_232 (37) = happyShift action_26
action_232 (38) = happyShift action_27
action_232 (39) = happyShift action_28
action_232 (40) = happyShift action_29
action_232 (45) = happyShift action_30
action_232 (46) = happyShift action_31
action_232 (49) = happyShift action_32
action_232 (52) = happyShift action_33
action_232 (53) = happyShift action_34
action_232 (54) = happyShift action_35
action_232 (55) = happyShift action_36
action_232 (57) = happyShift action_37
action_232 (59) = happyShift action_38
action_232 (61) = happyShift action_39
action_232 (68) = happyShift action_40
action_232 (72) = happyShift action_41
action_232 (95) = happyShift action_42
action_232 (96) = happyShift action_43
action_232 (97) = happyShift action_44
action_232 (98) = happyShift action_45
action_232 (99) = happyShift action_46
action_232 (100) = happyShift action_47
action_232 (5) = happyGoto action_240
action_232 (6) = happyGoto action_6
action_232 (7) = happyGoto action_7
action_232 (9) = happyGoto action_8
action_232 (10) = happyGoto action_9
action_232 (12) = happyGoto action_10
action_232 (13) = happyGoto action_11
action_232 (14) = happyGoto action_12
action_232 (16) = happyGoto action_13
action_232 _ = happyFail (happyExpListPerState 232)

action_233 (23) = happyShift action_16
action_233 (24) = happyShift action_17
action_233 (30) = happyShift action_23
action_233 (37) = happyShift action_26
action_233 (38) = happyShift action_27
action_233 (39) = happyShift action_28
action_233 (40) = happyShift action_29
action_233 (45) = happyShift action_30
action_233 (57) = happyShift action_50
action_233 (59) = happyShift action_51
action_233 (61) = happyShift action_39
action_233 (72) = happyShift action_41
action_233 (95) = happyShift action_42
action_233 (96) = happyShift action_43
action_233 (97) = happyShift action_44
action_233 (98) = happyShift action_45
action_233 (99) = happyShift action_46
action_233 (100) = happyShift action_47
action_233 (13) = happyGoto action_48
action_233 (14) = happyGoto action_239
action_233 (16) = happyGoto action_13
action_233 _ = happyFail (happyExpListPerState 233)

action_234 _ = happyReduce_21

action_235 (23) = happyShift action_16
action_235 (24) = happyShift action_17
action_235 (30) = happyShift action_23
action_235 (37) = happyShift action_26
action_235 (38) = happyShift action_27
action_235 (39) = happyShift action_28
action_235 (40) = happyShift action_29
action_235 (45) = happyShift action_30
action_235 (57) = happyShift action_50
action_235 (59) = happyShift action_51
action_235 (61) = happyShift action_39
action_235 (72) = happyShift action_41
action_235 (95) = happyShift action_42
action_235 (96) = happyShift action_43
action_235 (97) = happyShift action_44
action_235 (98) = happyShift action_45
action_235 (99) = happyShift action_46
action_235 (100) = happyShift action_47
action_235 (13) = happyGoto action_48
action_235 (14) = happyGoto action_238
action_235 (16) = happyGoto action_13
action_235 _ = happyFail (happyExpListPerState 235)

action_236 (22) = happyShift action_15
action_236 (23) = happyShift action_16
action_236 (24) = happyShift action_17
action_236 (25) = happyShift action_18
action_236 (26) = happyShift action_19
action_236 (27) = happyShift action_20
action_236 (28) = happyShift action_21
action_236 (29) = happyShift action_22
action_236 (30) = happyShift action_23
action_236 (33) = happyShift action_24
action_236 (34) = happyShift action_25
action_236 (37) = happyShift action_26
action_236 (38) = happyShift action_27
action_236 (39) = happyShift action_28
action_236 (40) = happyShift action_29
action_236 (45) = happyShift action_30
action_236 (46) = happyShift action_31
action_236 (49) = happyShift action_32
action_236 (52) = happyShift action_33
action_236 (53) = happyShift action_34
action_236 (54) = happyShift action_35
action_236 (55) = happyShift action_36
action_236 (57) = happyShift action_37
action_236 (59) = happyShift action_38
action_236 (61) = happyShift action_39
action_236 (68) = happyShift action_40
action_236 (72) = happyShift action_41
action_236 (95) = happyShift action_42
action_236 (96) = happyShift action_43
action_236 (97) = happyShift action_44
action_236 (98) = happyShift action_45
action_236 (99) = happyShift action_46
action_236 (100) = happyShift action_47
action_236 (5) = happyGoto action_237
action_236 (6) = happyGoto action_6
action_236 (7) = happyGoto action_7
action_236 (9) = happyGoto action_8
action_236 (10) = happyGoto action_9
action_236 (12) = happyGoto action_10
action_236 (13) = happyGoto action_11
action_236 (14) = happyGoto action_12
action_236 (16) = happyGoto action_13
action_236 _ = happyFail (happyExpListPerState 236)

action_237 (62) = happyShift action_244
action_237 _ = happyFail (happyExpListPerState 237)

action_238 (58) = happyShift action_243
action_238 (70) = happyShift action_81
action_238 (72) = happyShift action_82
action_238 (74) = happyShift action_83
action_238 (76) = happyShift action_84
action_238 (78) = happyShift action_85
action_238 (80) = happyShift action_86
action_238 (82) = happyShift action_87
action_238 (84) = happyShift action_88
action_238 (85) = happyShift action_89
action_238 (86) = happyShift action_90
action_238 (87) = happyShift action_91
action_238 (88) = happyShift action_92
action_238 (89) = happyShift action_93
action_238 (90) = happyShift action_94
action_238 (91) = happyShift action_95
action_238 (92) = happyShift action_96
action_238 (93) = happyShift action_97
action_238 _ = happyFail (happyExpListPerState 238)

action_239 (58) = happyShift action_242
action_239 (70) = happyShift action_81
action_239 (72) = happyShift action_82
action_239 (74) = happyShift action_83
action_239 (76) = happyShift action_84
action_239 (78) = happyShift action_85
action_239 (80) = happyShift action_86
action_239 (82) = happyShift action_87
action_239 (84) = happyShift action_88
action_239 (85) = happyShift action_89
action_239 (86) = happyShift action_90
action_239 (87) = happyShift action_91
action_239 (88) = happyShift action_92
action_239 (89) = happyShift action_93
action_239 (90) = happyShift action_94
action_239 (91) = happyShift action_95
action_239 (92) = happyShift action_96
action_239 (93) = happyShift action_97
action_239 _ = happyFail (happyExpListPerState 239)

action_240 (62) = happyShift action_241
action_240 _ = happyFail (happyExpListPerState 240)

action_241 _ = happyReduce_32

action_242 (61) = happyShift action_245
action_242 _ = happyFail (happyExpListPerState 242)

action_243 _ = happyReduce_20

action_244 _ = happyReduce_36

action_245 (22) = happyShift action_15
action_245 (23) = happyShift action_16
action_245 (24) = happyShift action_17
action_245 (25) = happyShift action_18
action_245 (26) = happyShift action_19
action_245 (27) = happyShift action_20
action_245 (28) = happyShift action_21
action_245 (29) = happyShift action_22
action_245 (30) = happyShift action_23
action_245 (33) = happyShift action_24
action_245 (34) = happyShift action_25
action_245 (37) = happyShift action_26
action_245 (38) = happyShift action_27
action_245 (39) = happyShift action_28
action_245 (40) = happyShift action_29
action_245 (45) = happyShift action_30
action_245 (46) = happyShift action_31
action_245 (49) = happyShift action_32
action_245 (52) = happyShift action_33
action_245 (53) = happyShift action_34
action_245 (54) = happyShift action_35
action_245 (55) = happyShift action_36
action_245 (57) = happyShift action_37
action_245 (59) = happyShift action_38
action_245 (61) = happyShift action_39
action_245 (68) = happyShift action_40
action_245 (72) = happyShift action_41
action_245 (95) = happyShift action_42
action_245 (96) = happyShift action_43
action_245 (97) = happyShift action_44
action_245 (98) = happyShift action_45
action_245 (99) = happyShift action_46
action_245 (100) = happyShift action_47
action_245 (5) = happyGoto action_246
action_245 (6) = happyGoto action_6
action_245 (7) = happyGoto action_7
action_245 (9) = happyGoto action_8
action_245 (10) = happyGoto action_9
action_245 (12) = happyGoto action_10
action_245 (13) = happyGoto action_11
action_245 (14) = happyGoto action_12
action_245 (16) = happyGoto action_13
action_245 _ = happyFail (happyExpListPerState 245)

action_246 (62) = happyShift action_247
action_246 _ = happyFail (happyExpListPerState 246)

action_247 (47) = happyShift action_230
action_247 (48) = happyShift action_231
action_247 (8) = happyGoto action_248
action_247 _ = happyReduce_31

action_248 _ = happyReduce_33

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

happyReduce_6 = happySpecReduce_2  6 happyReduction_6
happyReduction_6 (HappyTerminal (TkId happy_var_2))
	(HappyAbsSyn10  happy_var_1)
	 =  HappyAbsSyn6
		 (Declar happy_var_1 (fst happy_var_2)
	)
happyReduction_6 _ _  = notHappyAtAll 

happyReduce_7 = happyReduce 4 6 happyReduction_7
happyReduction_7 ((HappyAbsSyn14  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TkId happy_var_2)) `HappyStk`
	(HappyAbsSyn10  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn6
		 (DeclarI happy_var_1 (fst happy_var_2) happy_var_4
	) `HappyStk` happyRest

happyReduce_8 = happySpecReduce_1  6 happyReduction_8
happyReduction_8 (HappyAbsSyn14  happy_var_1)
	 =  HappyAbsSyn6
		 (Flotando happy_var_1
	)
happyReduction_8 _  = notHappyAtAll 

happyReduce_9 = happySpecReduce_3  6 happyReduction_9
happyReduction_9 (HappyAbsSyn14  happy_var_3)
	_
	(HappyAbsSyn13  happy_var_1)
	 =  HappyAbsSyn6
		 (Asig happy_var_1 happy_var_3
	)
happyReduction_9 _ _ _  = notHappyAtAll 

happyReduce_10 = happySpecReduce_3  6 happyReduction_10
happyReduction_10 (HappyAbsSyn14  happy_var_3)
	_
	(HappyAbsSyn13  happy_var_1)
	 =  HappyAbsSyn6
		 (Asig happy_var_1 (Sum (Lval happy_var_1) happy_var_3)
	)
happyReduction_10 _ _ _  = notHappyAtAll 

happyReduce_11 = happySpecReduce_3  6 happyReduction_11
happyReduction_11 (HappyAbsSyn14  happy_var_3)
	_
	(HappyAbsSyn13  happy_var_1)
	 =  HappyAbsSyn6
		 (Asig happy_var_1 (Sub (Lval happy_var_1) happy_var_3)
	)
happyReduction_11 _ _ _  = notHappyAtAll 

happyReduce_12 = happySpecReduce_3  6 happyReduction_12
happyReduction_12 (HappyAbsSyn14  happy_var_3)
	_
	(HappyAbsSyn13  happy_var_1)
	 =  HappyAbsSyn6
		 (Asig happy_var_1 (Mul (Lval happy_var_1) happy_var_3)
	)
happyReduction_12 _ _ _  = notHappyAtAll 

happyReduce_13 = happySpecReduce_3  6 happyReduction_13
happyReduction_13 (HappyAbsSyn14  happy_var_3)
	_
	(HappyAbsSyn13  happy_var_1)
	 =  HappyAbsSyn6
		 (Asig happy_var_1 (Div (Lval happy_var_1) happy_var_3)
	)
happyReduction_13 _ _ _  = notHappyAtAll 

happyReduce_14 = happySpecReduce_3  6 happyReduction_14
happyReduction_14 (HappyAbsSyn14  happy_var_3)
	_
	(HappyAbsSyn13  happy_var_1)
	 =  HappyAbsSyn6
		 (Asig happy_var_1 (DivE (Lval happy_var_1) happy_var_3)
	)
happyReduction_14 _ _ _  = notHappyAtAll 

happyReduce_15 = happySpecReduce_3  6 happyReduction_15
happyReduction_15 (HappyAbsSyn14  happy_var_3)
	_
	(HappyAbsSyn13  happy_var_1)
	 =  HappyAbsSyn6
		 (Asig happy_var_1 (Mod (Lval happy_var_1) happy_var_3)
	)
happyReduction_15 _ _ _  = notHappyAtAll 

happyReduce_16 = happySpecReduce_3  6 happyReduction_16
happyReduction_16 (HappyAbsSyn14  happy_var_3)
	_
	(HappyAbsSyn13  happy_var_1)
	 =  HappyAbsSyn6
		 (Asig happy_var_1 (Pow (Lval happy_var_1) happy_var_3)
	)
happyReduction_16 _ _ _  = notHappyAtAll 

happyReduce_17 = happySpecReduce_1  6 happyReduction_17
happyReduction_17 (HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn6
		 (happy_var_1
	)
happyReduction_17 _  = notHappyAtAll 

happyReduce_18 = happySpecReduce_1  6 happyReduction_18
happyReduction_18 (HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn6
		 (happy_var_1
	)
happyReduction_18 _  = notHappyAtAll 

happyReduce_19 = happyReduce 7 6 happyReduction_19
happyReduction_19 (_ `HappyStk`
	(HappyAbsSyn5  happy_var_6) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn14  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TkId happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn6
		 (Foreach (fst happy_var_2) happy_var_4 happy_var_6
	) `HappyStk` happyRest

happyReduce_20 = happyReduce 11 6 happyReduction_20
happyReduction_20 (_ `HappyStk`
	(HappyAbsSyn14  happy_var_10) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn14  happy_var_8) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn14  happy_var_6) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn6
		 (ForRange happy_var_6 happy_var_8 happy_var_10
	) `HappyStk` happyRest

happyReduce_21 = happyReduce 9 6 happyReduction_21
happyReduction_21 (_ `HappyStk`
	(HappyAbsSyn14  happy_var_8) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn14  happy_var_6) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn6
		 (ForRange happy_var_6 happy_var_8 (IntLit 1)
	) `HappyStk` happyRest

happyReduce_22 = happyReduce 7 6 happyReduction_22
happyReduction_22 (_ `HappyStk`
	(HappyAbsSyn14  happy_var_6) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn6
		 (ForRange (IntLit 0) happy_var_6 (IntLit 1)
	) `HappyStk` happyRest

happyReduce_23 = happySpecReduce_1  6 happyReduction_23
happyReduction_23 _
	 =  HappyAbsSyn6
		 (Break (IntLit 1)
	)

happyReduce_24 = happySpecReduce_2  6 happyReduction_24
happyReduction_24 (HappyAbsSyn14  happy_var_2)
	_
	 =  HappyAbsSyn6
		 (Break happy_var_2
	)
happyReduction_24 _ _  = notHappyAtAll 

happyReduce_25 = happySpecReduce_1  6 happyReduction_25
happyReduction_25 _
	 =  HappyAbsSyn6
		 (Continue
	)

happyReduce_26 = happySpecReduce_2  6 happyReduction_26
happyReduction_26 (HappyAbsSyn14  happy_var_2)
	_
	 =  HappyAbsSyn6
		 (Return happy_var_2
	)
happyReduction_26 _ _  = notHappyAtAll 

happyReduce_27 = happySpecReduce_1  6 happyReduction_27
happyReduction_27 _
	 =  HappyAbsSyn6
		 (Returnsito
	)

happyReduce_28 = happyReduce 7 7 happyReduction_28
happyReduction_28 (_ `HappyStk`
	(HappyAbsSyn5  happy_var_6) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn14  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn7
		 (If [(happy_var_3, happy_var_6)]
	) `HappyStk` happyRest

happyReduce_29 = happyReduce 7 7 happyReduction_29
happyReduction_29 (_ `HappyStk`
	(HappyAbsSyn5  happy_var_6) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn14  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn7
		 (If [(Not happy_var_3, happy_var_6)]
	) `HappyStk` happyRest

happyReduce_30 = happyReduce 8 7 happyReduction_30
happyReduction_30 ((HappyAbsSyn8  happy_var_8) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn5  happy_var_6) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn14  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn7
		 (If ((happy_var_3, happy_var_6) : happy_var_8)
	) `HappyStk` happyRest

happyReduce_31 = happyReduce 7 8 happyReduction_31
happyReduction_31 (_ `HappyStk`
	(HappyAbsSyn5  happy_var_6) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn14  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn8
		 ([(happy_var_3, happy_var_6)]
	) `HappyStk` happyRest

happyReduce_32 = happyReduce 4 8 happyReduction_32
happyReduction_32 (_ `HappyStk`
	(HappyAbsSyn5  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn8
		 ([(Full, happy_var_3)]
	) `HappyStk` happyRest

happyReduce_33 = happyReduce 8 8 happyReduction_33
happyReduction_33 ((HappyAbsSyn8  happy_var_8) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn5  happy_var_6) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn14  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn8
		 ((happy_var_3, happy_var_6) : happy_var_8
	) `HappyStk` happyRest

happyReduce_34 = happyReduce 8 9 happyReduction_34
happyReduction_34 (_ `HappyStk`
	(HappyAbsSyn5  happy_var_7) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn14  happy_var_4) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn9
		 (While happy_var_4 happy_var_7
	) `HappyStk` happyRest

happyReduce_35 = happyReduce 8 9 happyReduction_35
happyReduction_35 (_ `HappyStk`
	(HappyAbsSyn5  happy_var_7) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn14  happy_var_4) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn9
		 (While (Not happy_var_4) happy_var_7
	) `HappyStk` happyRest

happyReduce_36 = happyReduce 11 9 happyReduction_36
happyReduction_36 (_ `HappyStk`
	(HappyAbsSyn5  happy_var_10) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn6  happy_var_7) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn14  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn6  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn9
		 (While happy_var_5 (happy_var_3 : happy_var_10 ++ [happy_var_7])
	) `HappyStk` happyRest

happyReduce_37 = happySpecReduce_1  10 happyReduction_37
happyReduction_37 _
	 =  HappyAbsSyn10
		 (Planet
	)

happyReduce_38 = happySpecReduce_1  10 happyReduction_38
happyReduction_38 _
	 =  HappyAbsSyn10
		 (Cloud
	)

happyReduce_39 = happySpecReduce_1  10 happyReduction_39
happyReduction_39 _
	 =  HappyAbsSyn10
		 (Star
	)

happyReduce_40 = happySpecReduce_1  10 happyReduction_40
happyReduction_40 _
	 =  HappyAbsSyn10
		 (Moon
	)

happyReduce_41 = happySpecReduce_1  10 happyReduction_41
happyReduction_41 _
	 =  HappyAbsSyn10
		 (Blackhole
	)

happyReduce_42 = happySpecReduce_1  10 happyReduction_42
happyReduction_42 _
	 =  HappyAbsSyn10
		 (Cluster Star
	)

happyReduce_43 = happySpecReduce_1  10 happyReduction_43
happyReduction_43 (HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn10
		 (happy_var_1
	)
happyReduction_43 _  = notHappyAtAll 

happyReduce_44 = happySpecReduce_1  11 happyReduction_44
happyReduction_44 (HappyAbsSyn10  happy_var_1)
	 =  HappyAbsSyn11
		 ([happy_var_1]
	)
happyReduction_44 _  = notHappyAtAll 

happyReduce_45 = happySpecReduce_3  11 happyReduction_45
happyReduction_45 (HappyAbsSyn11  happy_var_3)
	_
	(HappyAbsSyn10  happy_var_1)
	 =  HappyAbsSyn11
		 (happy_var_1 : happy_var_3
	)
happyReduction_45 _ _ _  = notHappyAtAll 

happyReduce_46 = happyReduce 4 12 happyReduction_46
happyReduction_46 (_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn10  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn12
		 (Cluster happy_var_2
	) `HappyStk` happyRest

happyReduce_47 = happyReduce 4 12 happyReduction_47
happyReduction_47 (_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn10  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn12
		 (Quasar happy_var_2
	) `HappyStk` happyRest

happyReduce_48 = happyReduce 4 12 happyReduction_48
happyReduction_48 (_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn10  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn12
		 (Nebula happy_var_2
	) `HappyStk` happyRest

happyReduce_49 = happyReduce 4 12 happyReduction_49
happyReduction_49 (_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn10  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn12
		 (Satellite happy_var_2
	) `HappyStk` happyRest

happyReduce_50 = happySpecReduce_2  12 happyReduction_50
happyReduction_50 (HappyAbsSyn10  happy_var_2)
	_
	 =  HappyAbsSyn12
		 (Pointer happy_var_2
	)
happyReduction_50 _ _  = notHappyAtAll 

happyReduce_51 = happySpecReduce_2  12 happyReduction_51
happyReduction_51 (HappyTerminal (TkId happy_var_2))
	_
	 =  HappyAbsSyn12
		 (Galaxy (fst happy_var_2)
	)
happyReduction_51 _ _  = notHappyAtAll 

happyReduce_52 = happySpecReduce_2  12 happyReduction_52
happyReduction_52 (HappyTerminal (TkId happy_var_2))
	_
	 =  HappyAbsSyn12
		 (UFO (fst happy_var_2)
	)
happyReduction_52 _ _  = notHappyAtAll 

happyReduce_53 = happyReduce 5 12 happyReduction_53
happyReduction_53 ((HappyTerminal (TkParC      happy_var_5)) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn11  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn12
		 (Comet happy_var_2 happy_var_5
	) `HappyStk` happyRest

happyReduce_54 = happySpecReduce_1  13 happyReduction_54
happyReduction_54 (HappyTerminal (TkId happy_var_1))
	 =  HappyAbsSyn13
		 (Var (fst happy_var_1)
	)
happyReduction_54 _  = notHappyAtAll 

happyReduce_55 = happySpecReduce_3  13 happyReduction_55
happyReduction_55 (HappyTerminal (TkId happy_var_3))
	_
	(HappyAbsSyn13  happy_var_1)
	 =  HappyAbsSyn13
		 (Attr happy_var_1 (fst happy_var_3)
	)
happyReduction_55 _ _ _  = notHappyAtAll 

happyReduce_56 = happySpecReduce_2  13 happyReduction_56
happyReduction_56 (HappyAbsSyn15  happy_var_2)
	(HappyAbsSyn13  happy_var_1)
	 =  HappyAbsSyn13
		 (Access happy_var_1 happy_var_2
	)
happyReduction_56 _ _  = notHappyAtAll 

happyReduce_57 = happySpecReduce_3  14 happyReduction_57
happyReduction_57 _
	(HappyAbsSyn14  happy_var_2)
	_
	 =  HappyAbsSyn14
		 (happy_var_2
	)
happyReduction_57 _ _ _  = notHappyAtAll 

happyReduce_58 = happySpecReduce_1  14 happyReduction_58
happyReduction_58 (HappyAbsSyn16  happy_var_1)
	 =  HappyAbsSyn14
		 (happy_var_1
	)
happyReduction_58 _  = notHappyAtAll 

happyReduce_59 = happyReduce 4 14 happyReduction_59
happyReduction_59 (_ `HappyStk`
	(HappyAbsSyn17  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn14
		 (Print happy_var_3
	) `HappyStk` happyRest

happyReduce_60 = happySpecReduce_3  14 happyReduction_60
happyReduction_60 _
	_
	_
	 =  HappyAbsSyn14
		 (Read
	)

happyReduce_61 = happySpecReduce_3  14 happyReduction_61
happyReduction_61 _
	_
	_
	 =  HappyAbsSyn14
		 (Bigbang
	)

happyReduce_62 = happyReduce 4 14 happyReduction_62
happyReduction_62 (_ `HappyStk`
	(HappyAbsSyn14  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn14
		 (Scale happy_var_3
	) `HappyStk` happyRest

happyReduce_63 = happyReduce 4 14 happyReduction_63
happyReduction_63 (_ `HappyStk`
	(HappyAbsSyn14  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn14
		 (Terraform happy_var_3
	) `HappyStk` happyRest

happyReduce_64 = happySpecReduce_1  14 happyReduction_64
happyReduction_64 (HappyAbsSyn13  happy_var_1)
	 =  HappyAbsSyn14
		 (Lval happy_var_1
	)
happyReduction_64 _  = notHappyAtAll 

happyReduce_65 = happySpecReduce_1  14 happyReduction_65
happyReduction_65 (HappyTerminal (TkInt happy_var_1))
	 =  HappyAbsSyn14
		 (IntLit (fst happy_var_1)
	)
happyReduction_65 _  = notHappyAtAll 

happyReduce_66 = happySpecReduce_1  14 happyReduction_66
happyReduction_66 (HappyTerminal (TkFloat happy_var_1))
	 =  HappyAbsSyn14
		 (FloLit (fst happy_var_1)
	)
happyReduction_66 _  = notHappyAtAll 

happyReduce_67 = happySpecReduce_3  14 happyReduction_67
happyReduction_67 (HappyAbsSyn14  happy_var_3)
	_
	(HappyAbsSyn14  happy_var_1)
	 =  HappyAbsSyn14
		 (Sum happy_var_1 happy_var_3
	)
happyReduction_67 _ _ _  = notHappyAtAll 

happyReduce_68 = happySpecReduce_3  14 happyReduction_68
happyReduction_68 (HappyAbsSyn14  happy_var_3)
	_
	(HappyAbsSyn14  happy_var_1)
	 =  HappyAbsSyn14
		 (Sub happy_var_1 happy_var_3
	)
happyReduction_68 _ _ _  = notHappyAtAll 

happyReduce_69 = happySpecReduce_3  14 happyReduction_69
happyReduction_69 (HappyAbsSyn14  happy_var_3)
	_
	(HappyAbsSyn14  happy_var_1)
	 =  HappyAbsSyn14
		 (Mul happy_var_1 happy_var_3
	)
happyReduction_69 _ _ _  = notHappyAtAll 

happyReduce_70 = happySpecReduce_3  14 happyReduction_70
happyReduction_70 (HappyAbsSyn14  happy_var_3)
	_
	(HappyAbsSyn14  happy_var_1)
	 =  HappyAbsSyn14
		 (Div happy_var_1 happy_var_3
	)
happyReduction_70 _ _ _  = notHappyAtAll 

happyReduce_71 = happySpecReduce_3  14 happyReduction_71
happyReduction_71 (HappyAbsSyn14  happy_var_3)
	_
	(HappyAbsSyn14  happy_var_1)
	 =  HappyAbsSyn14
		 (DivE happy_var_1 happy_var_3
	)
happyReduction_71 _ _ _  = notHappyAtAll 

happyReduce_72 = happySpecReduce_3  14 happyReduction_72
happyReduction_72 (HappyAbsSyn14  happy_var_3)
	_
	(HappyAbsSyn14  happy_var_1)
	 =  HappyAbsSyn14
		 (Mod happy_var_1 happy_var_3
	)
happyReduction_72 _ _ _  = notHappyAtAll 

happyReduce_73 = happySpecReduce_3  14 happyReduction_73
happyReduction_73 (HappyAbsSyn14  happy_var_3)
	_
	(HappyAbsSyn14  happy_var_1)
	 =  HappyAbsSyn14
		 (Pow happy_var_1 happy_var_3
	)
happyReduction_73 _ _ _  = notHappyAtAll 

happyReduce_74 = happySpecReduce_2  14 happyReduction_74
happyReduction_74 (HappyAbsSyn14  happy_var_2)
	_
	 =  HappyAbsSyn14
		 (Neg happy_var_2
	)
happyReduction_74 _ _  = notHappyAtAll 

happyReduce_75 = happySpecReduce_3  14 happyReduction_75
happyReduction_75 (HappyAbsSyn14  happy_var_3)
	_
	(HappyAbsSyn14  happy_var_1)
	 =  HappyAbsSyn14
		 (Eq happy_var_1 happy_var_3
	)
happyReduction_75 _ _ _  = notHappyAtAll 

happyReduce_76 = happySpecReduce_3  14 happyReduction_76
happyReduction_76 (HappyAbsSyn14  happy_var_3)
	_
	(HappyAbsSyn14  happy_var_1)
	 =  HappyAbsSyn14
		 (Neq happy_var_1 happy_var_3
	)
happyReduction_76 _ _ _  = notHappyAtAll 

happyReduce_77 = happySpecReduce_3  14 happyReduction_77
happyReduction_77 (HappyAbsSyn14  happy_var_3)
	_
	(HappyAbsSyn14  happy_var_1)
	 =  HappyAbsSyn14
		 (Mayor happy_var_1 happy_var_3
	)
happyReduction_77 _ _ _  = notHappyAtAll 

happyReduce_78 = happySpecReduce_3  14 happyReduction_78
happyReduction_78 (HappyAbsSyn14  happy_var_3)
	_
	(HappyAbsSyn14  happy_var_1)
	 =  HappyAbsSyn14
		 (MayorI happy_var_1 happy_var_3
	)
happyReduction_78 _ _ _  = notHappyAtAll 

happyReduce_79 = happySpecReduce_3  14 happyReduction_79
happyReduction_79 (HappyAbsSyn14  happy_var_3)
	_
	(HappyAbsSyn14  happy_var_1)
	 =  HappyAbsSyn14
		 (Menor happy_var_1 happy_var_3
	)
happyReduction_79 _ _ _  = notHappyAtAll 

happyReduce_80 = happySpecReduce_3  14 happyReduction_80
happyReduction_80 (HappyAbsSyn14  happy_var_3)
	_
	(HappyAbsSyn14  happy_var_1)
	 =  HappyAbsSyn14
		 (MenorI happy_var_1 happy_var_3
	)
happyReduction_80 _ _ _  = notHappyAtAll 

happyReduce_81 = happySpecReduce_1  14 happyReduction_81
happyReduction_81 _
	 =  HappyAbsSyn14
		 (New
	)

happyReduce_82 = happySpecReduce_1  14 happyReduction_82
happyReduction_82 _
	 =  HappyAbsSyn14
		 (Full
	)

happyReduce_83 = happySpecReduce_3  14 happyReduction_83
happyReduction_83 (HappyAbsSyn14  happy_var_3)
	_
	(HappyAbsSyn14  happy_var_1)
	 =  HappyAbsSyn14
		 (And happy_var_1 happy_var_3
	)
happyReduction_83 _ _ _  = notHappyAtAll 

happyReduce_84 = happySpecReduce_3  14 happyReduction_84
happyReduction_84 (HappyAbsSyn14  happy_var_3)
	_
	(HappyAbsSyn14  happy_var_1)
	 =  HappyAbsSyn14
		 (Bitand happy_var_1 happy_var_3
	)
happyReduction_84 _ _ _  = notHappyAtAll 

happyReduce_85 = happySpecReduce_3  14 happyReduction_85
happyReduction_85 (HappyAbsSyn14  happy_var_3)
	_
	(HappyAbsSyn14  happy_var_1)
	 =  HappyAbsSyn14
		 (Or happy_var_1 happy_var_3
	)
happyReduction_85 _ _ _  = notHappyAtAll 

happyReduce_86 = happySpecReduce_3  14 happyReduction_86
happyReduction_86 (HappyAbsSyn14  happy_var_3)
	_
	(HappyAbsSyn14  happy_var_1)
	 =  HappyAbsSyn14
		 (Bitor happy_var_1 happy_var_3
	)
happyReduction_86 _ _ _  = notHappyAtAll 

happyReduce_87 = happySpecReduce_2  14 happyReduction_87
happyReduction_87 (HappyAbsSyn14  happy_var_2)
	_
	 =  HappyAbsSyn14
		 (Not happy_var_2
	)
happyReduction_87 _ _  = notHappyAtAll 

happyReduce_88 = happySpecReduce_1  14 happyReduction_88
happyReduction_88 (HappyTerminal (TkString happy_var_1))
	 =  HappyAbsSyn14
		 (StrLit (fst happy_var_1)
	)
happyReduction_88 _  = notHappyAtAll 

happyReduce_89 = happySpecReduce_1  14 happyReduction_89
happyReduction_89 (HappyTerminal (TkChar happy_var_1))
	 =  HappyAbsSyn14
		 (CharLit (fst happy_var_1)
	)
happyReduction_89 _  = notHappyAtAll 

happyReduce_90 = happySpecReduce_3  14 happyReduction_90
happyReduction_90 _
	(HappyAbsSyn17  happy_var_2)
	_
	 =  HappyAbsSyn14
		 (ListLit happy_var_2
	)
happyReduction_90 _ _ _  = notHappyAtAll 

happyReduce_91 = happySpecReduce_3  14 happyReduction_91
happyReduction_91 _
	(HappyAbsSyn17  happy_var_2)
	_
	 =  HappyAbsSyn14
		 (ArrLit happy_var_2
	)
happyReduction_91 _ _ _  = notHappyAtAll 

happyReduce_92 = happyReduce 5 14 happyReduction_92
happyReduction_92 ((HappyAbsSyn10  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn14  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn14
		 (ArrInit happy_var_3 happy_var_5
	) `HappyStk` happyRest

happyReduce_93 = happySpecReduce_3  14 happyReduction_93
happyReduction_93 _
	(HappyAbsSyn18  happy_var_2)
	_
	 =  HappyAbsSyn14
		 (DictLit happy_var_2
	)
happyReduction_93 _ _ _  = notHappyAtAll 

happyReduce_94 = happySpecReduce_3  15 happyReduction_94
happyReduction_94 _
	(HappyAbsSyn14  happy_var_2)
	_
	 =  HappyAbsSyn15
		 (Index happy_var_2
	)
happyReduction_94 _ _ _  = notHappyAtAll 

happyReduce_95 = happyReduce 4 15 happyReduction_95
happyReduction_95 ((HappyAbsSyn15  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn14  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn15
		 (ManyAc (Index happy_var_2) happy_var_4
	) `HappyStk` happyRest

happyReduce_96 = happyReduce 5 15 happyReduction_96
happyReduction_96 (_ `HappyStk`
	(HappyAbsSyn14  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn14  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn15
		 (Interval happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_97 = happyReduce 6 15 happyReduction_97
happyReduction_97 ((HappyAbsSyn15  happy_var_6) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn14  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn14  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn15
		 (ManyAc (Interval happy_var_2 happy_var_4) happy_var_6
	) `HappyStk` happyRest

happyReduce_98 = happyReduce 4 15 happyReduction_98
happyReduction_98 (_ `HappyStk`
	(HappyAbsSyn14  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn15
		 (Interval (IntLit 0) happy_var_3
	) `HappyStk` happyRest

happyReduce_99 = happyReduce 5 15 happyReduction_99
happyReduction_99 ((HappyAbsSyn15  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn14  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn15
		 (ManyAc (Interval (IntLit 0) happy_var_3) happy_var_5
	) `HappyStk` happyRest

happyReduce_100 = happyReduce 4 15 happyReduction_100
happyReduction_100 (_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn14  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn15
		 (Begin happy_var_2
	) `HappyStk` happyRest

happyReduce_101 = happyReduce 5 15 happyReduction_101
happyReduction_101 ((HappyAbsSyn15  happy_var_5) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn14  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn15
		 (ManyAc (Begin happy_var_2) happy_var_5
	) `HappyStk` happyRest

happyReduce_102 = happyReduce 4 16 happyReduction_102
happyReduction_102 (_ `HappyStk`
	(HappyAbsSyn17  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn13  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn16
		 (Funcall happy_var_1 happy_var_3
	) `HappyStk` happyRest

happyReduce_103 = happySpecReduce_3  16 happyReduction_103
happyReduction_103 _
	_
	(HappyAbsSyn13  happy_var_1)
	 =  HappyAbsSyn16
		 (Funcall happy_var_1 []
	)
happyReduction_103 _ _ _  = notHappyAtAll 

happyReduce_104 = happySpecReduce_3  17 happyReduction_104
happyReduction_104 (HappyAbsSyn17  happy_var_3)
	_
	(HappyAbsSyn14  happy_var_1)
	 =  HappyAbsSyn17
		 (happy_var_1 : happy_var_3
	)
happyReduction_104 _ _ _  = notHappyAtAll 

happyReduce_105 = happySpecReduce_1  17 happyReduction_105
happyReduction_105 (HappyAbsSyn14  happy_var_1)
	 =  HappyAbsSyn17
		 ([happy_var_1]
	)
happyReduction_105 _  = notHappyAtAll 

happyReduce_106 = happyReduce 5 18 happyReduction_106
happyReduction_106 ((HappyAbsSyn18  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn14  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn14  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn18
		 ((happy_var_1, happy_var_3) : happy_var_5
	) `HappyStk` happyRest

happyReduce_107 = happySpecReduce_3  18 happyReduction_107
happyReduction_107 (HappyAbsSyn14  happy_var_3)
	_
	(HappyAbsSyn14  happy_var_1)
	 =  HappyAbsSyn18
		 ([(happy_var_1, happy_var_3)]
	)
happyReduction_107 _ _ _  = notHappyAtAll 

happyReduce_108 = happyReduce 4 19 happyReduction_108
happyReduction_108 ((HappyAbsSyn19  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn14  happy_var_2) `HappyStk`
	(HappyAbsSyn10  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn19
		 ((happy_var_1, happy_var_2, False) : happy_var_4
	) `HappyStk` happyRest

happyReduce_109 = happySpecReduce_2  19 happyReduction_109
happyReduction_109 (HappyAbsSyn14  happy_var_2)
	(HappyAbsSyn10  happy_var_1)
	 =  HappyAbsSyn19
		 ([(happy_var_1, happy_var_2, False)]
	)
happyReduction_109 _ _  = notHappyAtAll 

happyReduce_110 = happyReduce 5 19 happyReduction_110
happyReduction_110 ((HappyAbsSyn19  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn14  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn10  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn19
		 ((happy_var_1, happy_var_3, True) : happy_var_5
	) `HappyStk` happyRest

happyReduce_111 = happySpecReduce_3  19 happyReduction_111
happyReduction_111 _
	_
	(HappyAbsSyn10  happy_var_1)
	 =  HappyAbsSyn19
		 ([(happy_var_1, True)]
	)
happyReduction_111 _ _ _  = notHappyAtAll 

happyNewToken action sts stk [] =
	action 101 101 notHappyAtAll (HappyState action) sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = action i i tk (HappyState action) sts stk tks in
	case tk of {
	TkSpace     happy_dollar_dollar -> cont 20;
	TkEndofSpace happy_dollar_dollar -> cont 21;
	TkMoon      happy_dollar_dollar -> cont 22;
	TkNew       happy_dollar_dollar -> cont 23;
	TkFull      happy_dollar_dollar -> cont 24;
	TkPlanet    happy_dollar_dollar -> cont 25;
	TkCloud     happy_dollar_dollar -> cont 26;
	TkStar      happy_dollar_dollar -> cont 27;
	TkBlackhole happy_dollar_dollar -> cont 28;
	TkConstellation happy_dollar_dollar -> cont 29;
	TkCluster   happy_dollar_dollar -> cont 30;
	TkQuasar    happy_dollar_dollar -> cont 31;
	TkNebula    happy_dollar_dollar -> cont 32;
	TkGalaxy    happy_dollar_dollar -> cont 33;
	TkUFO       happy_dollar_dollar -> cont 34;
	TkComet     happy_dollar_dollar -> cont 35;
	TkSatellite happy_dollar_dollar -> cont 36;
	TkTerraform happy_dollar_dollar -> cont 37;
	TkPrint     happy_dollar_dollar -> cont 38;
	TkRead      happy_dollar_dollar -> cont 39;
	TkScale     happy_dollar_dollar -> cont 40;
	TkAround    happy_dollar_dollar -> cont 41;
	TkRange     happy_dollar_dollar -> cont 42;
	TkPop       happy_dollar_dollar -> cont 43;
	TkAdd       happy_dollar_dollar -> cont 44;
	TkBigbang   happy_dollar_dollar -> cont 45;
	TkIf        happy_dollar_dollar -> cont 46;
	TkElseif    happy_dollar_dollar -> cont 47;
	TkElse      happy_dollar_dollar -> cont 48;
	TkUnless    happy_dollar_dollar -> cont 49;
	TkWhile     happy_dollar_dollar -> cont 50;
	TkUntil     happy_dollar_dollar -> cont 51;
	TkOrbit     happy_dollar_dollar -> cont 52;
	TkBreak happy_dollar_dollar -> cont 53;
	TkContinue happy_dollar_dollar -> cont 54;
	TkReturn happy_dollar_dollar -> cont 55;
	TkArroba      happy_dollar_dollar -> cont 56;
	TkParA      happy_dollar_dollar -> cont 57;
	TkParC      happy_dollar_dollar -> cont 58;
	TkCorA      happy_dollar_dollar -> cont 59;
	TkCorC      happy_dollar_dollar -> cont 60;
	TkLlavA     happy_dollar_dollar -> cont 61;
	TkLlavC     happy_dollar_dollar -> cont 62;
	TkPuntopunto happy_dollar_dollar -> cont 63;
	TkPunto     happy_dollar_dollar -> cont 64;
	TkComa      happy_dollar_dollar -> cont 65;
	TkPuntoycoma happy_dollar_dollar -> cont 66;
	TkDospuntos happy_dollar_dollar -> cont 67;
	TkNyangara  happy_dollar_dollar -> cont 68;
	TkMasIgual  happy_dollar_dollar -> cont 69;
	TkMas       happy_dollar_dollar -> cont 70;
	TkMenosIgual happy_dollar_dollar -> cont 71;
	TkMenos     happy_dollar_dollar -> cont 72;
	TkMultIgual happy_dollar_dollar -> cont 73;
	TkMult     happy_dollar_dollar -> cont 74;
	TkPotenciaIgual happy_dollar_dollar -> cont 75;
	TkPotencia  happy_dollar_dollar -> cont 76;
	TkDivEnteraIgual happy_dollar_dollar -> cont 77;
	TkDivEntera happy_dollar_dollar -> cont 78;
	TkDivIgual  happy_dollar_dollar -> cont 79;
	TkDiv       happy_dollar_dollar -> cont 80;
	TkModIgual  happy_dollar_dollar -> cont 81;
	TkMod       happy_dollar_dollar -> cont 82;
	TkFlechita  happy_dollar_dollar -> cont 83;
	TkMayorIgual happy_dollar_dollar -> cont 84;
	TkMayor     happy_dollar_dollar -> cont 85;
	TkMenorIgual happy_dollar_dollar -> cont 86;
	TkMenor     happy_dollar_dollar -> cont 87;
	TkAnd       happy_dollar_dollar -> cont 88;
	TkBitand    happy_dollar_dollar -> cont 89;
	TkOr        happy_dollar_dollar -> cont 90;
	TkBitor     happy_dollar_dollar -> cont 91;
	TkIgual     happy_dollar_dollar -> cont 92;
	TkDistinto  happy_dollar_dollar -> cont 93;
	TkAsignacion happy_dollar_dollar -> cont 94;
	TkNegacion  happy_dollar_dollar -> cont 95;
	TkString happy_dollar_dollar -> cont 96;
	TkChar happy_dollar_dollar -> cont 97;
	TkId happy_dollar_dollar -> cont 98;
	TkFloat happy_dollar_dollar -> cont 99;
	TkInt happy_dollar_dollar -> cont 100;
	_ -> happyError' ((tk:tks), [])
	}

happyError_ explist 101 tk tks = happyError' (tks, explist)
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
      = Flotando Exp
      | Declar Type String
      | DeclarI Type String Exp
      | Asig LValue Exp
      | If [(Exp, [Instr])]
      | While Exp [Instr]
      | Foreach String Exp [Instr]
      | ForRange Exp Exp Exp
      | Break Exp
      | Continue
      | Return Exp
      | Returnsito
      deriving Show

data Type
      = Planet
      | Cloud
      | Star
      | Moon
      | Blackhole
      | Cluster Type
      | Quasar Type
      | Nebula Type
      | Pointer Type
      | Satellite Type
      | Galaxy String
      | UFO String
      | Comet [Type] Type
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
      | Print [Exp]
      | Read
      | Bigbang
      | Scale Exp
      | Terraform Exp

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
      | ArrLit [Exp]
      | ArrInit Exp Type
      | ListLit [Exp]
      | DictLit [(Exp, Exp)]
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
