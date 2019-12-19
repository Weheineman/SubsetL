{-# OPTIONS_GHC -w #-}
module MyParser(parse) where

import MyLexer
import AST
import qualified Data.Array as Happy_Data_Array
import qualified Data.Bits as Bits
import Control.Applicative(Applicative(..))
import Control.Monad (ap)

-- parser produced by Happy Version 1.19.8

data HappyAbsSyn t4 t5 t6 t7 t8 t9 t10 t11 t12
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

happyExpList :: Happy_Data_Array.Array Int Int
happyExpList = Happy_Data_Array.listArray (0,549) ([0,7168,0,68,0,56,34816,32768,0,0,0,0,0,0,0,0,0,0,0,4,0,0,0,7,4352,0,3584,0,34,0,0,128,16384,0,0,0,0,0,128,1,57344,0,544,0,0,0,8,0,0,64,0,1792,0,17,0,0,16,28672,25088,7680,84,32768,0,0,0,28672,0,272,0,0,0,0,0,0,8,0,896,32768,8,8,0,0,0,0,0,4,0,0,0,0,1023,1019,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8192,28672,25088,7680,84,224,196,43068,0,0,0,0,0,0,0,0,8199,57350,1345,3584,3136,33728,10,8,0,0,4096,0,0,0,112,98,21534,57344,50176,15360,232,448,392,20600,1,4092,4076,1024,0,0,0,2,16368,16304,64,0,0,16384,0,0,256,8192,0,0,0,0,65280,64259,1027,0,0,0,1,0,4096,0,0,0,0,4,61440,15,0,0,8160,0,0,49152,63,0,0,0,0,0,57344,50176,15360,168,448,392,20600,32769,4099,61443,672,1792,1568,16864,5,16398,49164,2691,7168,6272,1920,21,56,49,10767,28672,25088,7680,84,224,196,43068,49152,34817,30721,336,896,784,41200,2,8199,57350,1345,3584,3136,33728,10,32796,32792,5383,14336,12544,3840,42,112,98,21534,57344,50176,15360,168,448,392,20600,32769,4099,61443,672,1792,1568,16864,5,0,0,0,0,0,0,32,0,0,16,32768,127,0,0,65280,0,0,0,510,0,0,64512,3,0,0,2040,0,0,61440,15,0,0,8160,0,0,49152,255,254,0,65408,64513,1,0,255,1016,0,65024,61441,7,0,124,0,0,63488,0,0,0,3568,0,0,0,0,0,0,0,0,0,0,0,0,0,7168,0,0,0,56,0,0,64512,60431,15,4,8199,57350,1345,3584,3136,33728,10,32796,32792,5383,14336,12544,3840,42,112,98,21534,57344,50176,15360,168,0,0,0,0,0,0,0,0,0,0,0,16368,16304,1056,57344,24703,127,2,65472,65216,0,32768,33279,509,2,65280,64259,3,0,0,0,0,896,784,41200,2,8184,8152,0,1024,0,0,0,0,0,0,14336,12544,3840,42,0,0,0,0,1023,1019,64,0,0,0,0,0,0,0,0
	])

{-# NOINLINE happyExpListPerState #-}
happyExpListPerState st =
    token_strs_expected
  where token_strs = ["error","%dummy","%start_parse","Stm","ExpList","Exp","Atom","UnOperation","BinOperation","Quantifier","IterList","Type","int","id","'~'","'+'","'-'","'*'","'/'","'%'","'..'","'<'","'>'","'='","'!='","'#'","tint","tbool","set","true","false","and","or","in","elem","subset","subsetEq","union","intersect","diff","cartProduct","first","second","exists","forall","':='","':'","';'","'|'","','","'['","']'","'{'","'}'","'('","')'","%eof"]
        bit_start = st * 57
        bit_end = (st + 1) * 57
        read_bit = readArrayBit happyExpList
        bits = map read_bit [bit_start..bit_end - 1]
        bits_indexed = zip bits [0..56]
        token_strs_expected = concatMap f bits_indexed
        f (False, _) = []
        f (True, nr) = [token_strs !! nr]

action_0 (27) = happyShift action_3
action_0 (28) = happyShift action_4
action_0 (29) = happyShift action_5
action_0 (51) = happyShift action_6
action_0 (55) = happyShift action_7
action_0 (4) = happyGoto action_8
action_0 (12) = happyGoto action_9
action_0 _ = happyFail (happyExpListPerState 0)

action_1 (27) = happyShift action_3
action_1 (28) = happyShift action_4
action_1 (29) = happyShift action_5
action_1 (51) = happyShift action_6
action_1 (55) = happyShift action_7
action_1 (12) = happyGoto action_2
action_1 _ = happyFail (happyExpListPerState 1)

action_2 (14) = happyShift action_15
action_2 _ = happyFail (happyExpListPerState 2)

action_3 _ = happyReduce_48

action_4 _ = happyReduce_49

action_5 (22) = happyShift action_14
action_5 _ = happyFail (happyExpListPerState 5)

action_6 (27) = happyShift action_3
action_6 (28) = happyShift action_4
action_6 (29) = happyShift action_5
action_6 (51) = happyShift action_6
action_6 (55) = happyShift action_7
action_6 (12) = happyGoto action_13
action_6 _ = happyFail (happyExpListPerState 6)

action_7 (27) = happyShift action_3
action_7 (28) = happyShift action_4
action_7 (29) = happyShift action_5
action_7 (51) = happyShift action_6
action_7 (55) = happyShift action_7
action_7 (12) = happyGoto action_12
action_7 _ = happyFail (happyExpListPerState 7)

action_8 (48) = happyShift action_11
action_8 (57) = happyAccept
action_8 _ = happyFail (happyExpListPerState 8)

action_9 (14) = happyShift action_10
action_9 _ = happyFail (happyExpListPerState 9)

action_10 (46) = happyShift action_16
action_10 (55) = happyShift action_21
action_10 _ = happyFail (happyExpListPerState 10)

action_11 (27) = happyShift action_3
action_11 (28) = happyShift action_4
action_11 (29) = happyShift action_5
action_11 (51) = happyShift action_6
action_11 (55) = happyShift action_7
action_11 (4) = happyGoto action_20
action_11 (12) = happyGoto action_9
action_11 _ = happyFail (happyExpListPerState 11)

action_12 (56) = happyShift action_19
action_12 _ = happyFail (happyExpListPerState 12)

action_13 (50) = happyShift action_18
action_13 _ = happyFail (happyExpListPerState 13)

action_14 (27) = happyShift action_3
action_14 (28) = happyShift action_4
action_14 (29) = happyShift action_5
action_14 (51) = happyShift action_6
action_14 (55) = happyShift action_7
action_14 (12) = happyGoto action_17
action_14 _ = happyFail (happyExpListPerState 14)

action_15 (46) = happyShift action_16
action_15 _ = happyFail (happyExpListPerState 15)

action_16 (13) = happyShift action_30
action_16 (14) = happyShift action_31
action_16 (15) = happyShift action_32
action_16 (26) = happyShift action_33
action_16 (30) = happyShift action_34
action_16 (31) = happyShift action_35
action_16 (42) = happyShift action_36
action_16 (43) = happyShift action_37
action_16 (44) = happyShift action_38
action_16 (45) = happyShift action_39
action_16 (51) = happyShift action_40
action_16 (53) = happyShift action_41
action_16 (55) = happyShift action_42
action_16 (6) = happyGoto action_25
action_16 (7) = happyGoto action_26
action_16 (8) = happyGoto action_27
action_16 (9) = happyGoto action_28
action_16 (10) = happyGoto action_29
action_16 _ = happyFail (happyExpListPerState 16)

action_17 (23) = happyShift action_24
action_17 _ = happyFail (happyExpListPerState 17)

action_18 (27) = happyShift action_3
action_18 (28) = happyShift action_4
action_18 (29) = happyShift action_5
action_18 (51) = happyShift action_6
action_18 (55) = happyShift action_7
action_18 (12) = happyGoto action_23
action_18 _ = happyFail (happyExpListPerState 18)

action_19 _ = happyReduce_52

action_20 (48) = happyShift action_11
action_20 _ = happyReduce_3

action_21 (27) = happyShift action_3
action_21 (28) = happyShift action_4
action_21 (29) = happyShift action_5
action_21 (51) = happyShift action_6
action_21 (55) = happyShift action_7
action_21 (12) = happyGoto action_22
action_21 _ = happyFail (happyExpListPerState 21)

action_22 (14) = happyShift action_78
action_22 _ = happyFail (happyExpListPerState 22)

action_23 (52) = happyShift action_77
action_23 _ = happyFail (happyExpListPerState 23)

action_24 _ = happyReduce_50

action_25 (16) = happyShift action_58
action_25 (17) = happyShift action_59
action_25 (18) = happyShift action_60
action_25 (19) = happyShift action_61
action_25 (20) = happyShift action_62
action_25 (21) = happyShift action_63
action_25 (22) = happyShift action_64
action_25 (23) = happyShift action_65
action_25 (24) = happyShift action_66
action_25 (25) = happyShift action_67
action_25 (32) = happyShift action_68
action_25 (33) = happyShift action_69
action_25 (35) = happyShift action_70
action_25 (36) = happyShift action_71
action_25 (37) = happyShift action_72
action_25 (38) = happyShift action_73
action_25 (39) = happyShift action_74
action_25 (40) = happyShift action_75
action_25 (41) = happyShift action_76
action_25 _ = happyReduce_1

action_26 _ = happyReduce_6

action_27 _ = happyReduce_7

action_28 _ = happyReduce_8

action_29 _ = happyReduce_9

action_30 _ = happyReduce_10

action_31 (55) = happyShift action_57
action_31 _ = happyReduce_13

action_32 (13) = happyShift action_30
action_32 (14) = happyShift action_31
action_32 (15) = happyShift action_32
action_32 (26) = happyShift action_33
action_32 (30) = happyShift action_34
action_32 (31) = happyShift action_35
action_32 (42) = happyShift action_36
action_32 (43) = happyShift action_37
action_32 (44) = happyShift action_38
action_32 (45) = happyShift action_39
action_32 (51) = happyShift action_40
action_32 (53) = happyShift action_41
action_32 (55) = happyShift action_42
action_32 (6) = happyGoto action_56
action_32 (7) = happyGoto action_26
action_32 (8) = happyGoto action_27
action_32 (9) = happyGoto action_28
action_32 (10) = happyGoto action_29
action_32 _ = happyFail (happyExpListPerState 32)

action_33 (13) = happyShift action_30
action_33 (14) = happyShift action_31
action_33 (15) = happyShift action_32
action_33 (26) = happyShift action_33
action_33 (30) = happyShift action_34
action_33 (31) = happyShift action_35
action_33 (42) = happyShift action_36
action_33 (43) = happyShift action_37
action_33 (44) = happyShift action_38
action_33 (45) = happyShift action_39
action_33 (51) = happyShift action_40
action_33 (53) = happyShift action_41
action_33 (55) = happyShift action_42
action_33 (6) = happyGoto action_55
action_33 (7) = happyGoto action_26
action_33 (8) = happyGoto action_27
action_33 (9) = happyGoto action_28
action_33 (10) = happyGoto action_29
action_33 _ = happyFail (happyExpListPerState 33)

action_34 _ = happyReduce_11

action_35 _ = happyReduce_12

action_36 (13) = happyShift action_30
action_36 (14) = happyShift action_31
action_36 (15) = happyShift action_32
action_36 (26) = happyShift action_33
action_36 (30) = happyShift action_34
action_36 (31) = happyShift action_35
action_36 (42) = happyShift action_36
action_36 (43) = happyShift action_37
action_36 (44) = happyShift action_38
action_36 (45) = happyShift action_39
action_36 (51) = happyShift action_40
action_36 (53) = happyShift action_41
action_36 (55) = happyShift action_42
action_36 (6) = happyGoto action_54
action_36 (7) = happyGoto action_26
action_36 (8) = happyGoto action_27
action_36 (9) = happyGoto action_28
action_36 (10) = happyGoto action_29
action_36 _ = happyFail (happyExpListPerState 36)

action_37 (13) = happyShift action_30
action_37 (14) = happyShift action_31
action_37 (15) = happyShift action_32
action_37 (26) = happyShift action_33
action_37 (30) = happyShift action_34
action_37 (31) = happyShift action_35
action_37 (42) = happyShift action_36
action_37 (43) = happyShift action_37
action_37 (44) = happyShift action_38
action_37 (45) = happyShift action_39
action_37 (51) = happyShift action_40
action_37 (53) = happyShift action_41
action_37 (55) = happyShift action_42
action_37 (6) = happyGoto action_53
action_37 (7) = happyGoto action_26
action_37 (8) = happyGoto action_27
action_37 (9) = happyGoto action_28
action_37 (10) = happyGoto action_29
action_37 _ = happyFail (happyExpListPerState 37)

action_38 (14) = happyShift action_51
action_38 (11) = happyGoto action_52
action_38 _ = happyFail (happyExpListPerState 38)

action_39 (14) = happyShift action_51
action_39 (11) = happyGoto action_50
action_39 _ = happyFail (happyExpListPerState 39)

action_40 (13) = happyShift action_30
action_40 (14) = happyShift action_31
action_40 (15) = happyShift action_32
action_40 (26) = happyShift action_33
action_40 (30) = happyShift action_34
action_40 (31) = happyShift action_35
action_40 (42) = happyShift action_36
action_40 (43) = happyShift action_37
action_40 (44) = happyShift action_38
action_40 (45) = happyShift action_39
action_40 (51) = happyShift action_40
action_40 (53) = happyShift action_41
action_40 (55) = happyShift action_42
action_40 (6) = happyGoto action_49
action_40 (7) = happyGoto action_26
action_40 (8) = happyGoto action_27
action_40 (9) = happyGoto action_28
action_40 (10) = happyGoto action_29
action_40 _ = happyFail (happyExpListPerState 40)

action_41 (13) = happyShift action_30
action_41 (14) = happyShift action_47
action_41 (15) = happyShift action_32
action_41 (26) = happyShift action_33
action_41 (30) = happyShift action_34
action_41 (31) = happyShift action_35
action_41 (42) = happyShift action_36
action_41 (43) = happyShift action_37
action_41 (44) = happyShift action_38
action_41 (45) = happyShift action_39
action_41 (51) = happyShift action_40
action_41 (53) = happyShift action_41
action_41 (54) = happyShift action_48
action_41 (55) = happyShift action_42
action_41 (5) = happyGoto action_44
action_41 (6) = happyGoto action_45
action_41 (7) = happyGoto action_26
action_41 (8) = happyGoto action_27
action_41 (9) = happyGoto action_28
action_41 (10) = happyGoto action_29
action_41 (11) = happyGoto action_46
action_41 _ = happyFail (happyExpListPerState 41)

action_42 (13) = happyShift action_30
action_42 (14) = happyShift action_31
action_42 (15) = happyShift action_32
action_42 (26) = happyShift action_33
action_42 (30) = happyShift action_34
action_42 (31) = happyShift action_35
action_42 (42) = happyShift action_36
action_42 (43) = happyShift action_37
action_42 (44) = happyShift action_38
action_42 (45) = happyShift action_39
action_42 (51) = happyShift action_40
action_42 (53) = happyShift action_41
action_42 (55) = happyShift action_42
action_42 (6) = happyGoto action_43
action_42 (7) = happyGoto action_26
action_42 (8) = happyGoto action_27
action_42 (9) = happyGoto action_28
action_42 (10) = happyGoto action_29
action_42 _ = happyFail (happyExpListPerState 42)

action_43 (16) = happyShift action_58
action_43 (17) = happyShift action_59
action_43 (18) = happyShift action_60
action_43 (19) = happyShift action_61
action_43 (20) = happyShift action_62
action_43 (21) = happyShift action_63
action_43 (22) = happyShift action_64
action_43 (23) = happyShift action_65
action_43 (24) = happyShift action_66
action_43 (25) = happyShift action_67
action_43 (32) = happyShift action_68
action_43 (33) = happyShift action_69
action_43 (35) = happyShift action_70
action_43 (36) = happyShift action_71
action_43 (37) = happyShift action_72
action_43 (38) = happyShift action_73
action_43 (39) = happyShift action_74
action_43 (40) = happyShift action_75
action_43 (41) = happyShift action_76
action_43 (56) = happyShift action_107
action_43 _ = happyFail (happyExpListPerState 43)

action_44 (54) = happyShift action_106
action_44 _ = happyFail (happyExpListPerState 44)

action_45 (16) = happyShift action_58
action_45 (17) = happyShift action_59
action_45 (18) = happyShift action_60
action_45 (19) = happyShift action_61
action_45 (20) = happyShift action_62
action_45 (21) = happyShift action_63
action_45 (22) = happyShift action_64
action_45 (23) = happyShift action_65
action_45 (24) = happyShift action_66
action_45 (25) = happyShift action_67
action_45 (32) = happyShift action_68
action_45 (33) = happyShift action_69
action_45 (35) = happyShift action_70
action_45 (36) = happyShift action_71
action_45 (37) = happyShift action_72
action_45 (38) = happyShift action_73
action_45 (39) = happyShift action_74
action_45 (40) = happyShift action_75
action_45 (41) = happyShift action_76
action_45 (50) = happyShift action_105
action_45 _ = happyReduce_5

action_46 (49) = happyShift action_104
action_46 _ = happyFail (happyExpListPerState 46)

action_47 (34) = happyShift action_101
action_47 (55) = happyShift action_57
action_47 _ = happyReduce_13

action_48 _ = happyReduce_15

action_49 (16) = happyShift action_58
action_49 (17) = happyShift action_59
action_49 (18) = happyShift action_60
action_49 (19) = happyShift action_61
action_49 (20) = happyShift action_62
action_49 (21) = happyShift action_63
action_49 (22) = happyShift action_64
action_49 (23) = happyShift action_65
action_49 (24) = happyShift action_66
action_49 (25) = happyShift action_67
action_49 (32) = happyShift action_68
action_49 (33) = happyShift action_69
action_49 (35) = happyShift action_70
action_49 (36) = happyShift action_71
action_49 (37) = happyShift action_72
action_49 (38) = happyShift action_73
action_49 (39) = happyShift action_74
action_49 (40) = happyShift action_75
action_49 (41) = happyShift action_76
action_49 (50) = happyShift action_103
action_49 _ = happyFail (happyExpListPerState 49)

action_50 (47) = happyShift action_102
action_50 _ = happyFail (happyExpListPerState 50)

action_51 (34) = happyShift action_101
action_51 _ = happyFail (happyExpListPerState 51)

action_52 (47) = happyShift action_100
action_52 _ = happyFail (happyExpListPerState 52)

action_53 (16) = happyShift action_58
action_53 (17) = happyShift action_59
action_53 (18) = happyShift action_60
action_53 (19) = happyShift action_61
action_53 (20) = happyShift action_62
action_53 (21) = happyShift action_63
action_53 (22) = happyShift action_64
action_53 (23) = happyShift action_65
action_53 _ = happyReduce_23

action_54 (16) = happyShift action_58
action_54 (17) = happyShift action_59
action_54 (18) = happyShift action_60
action_54 (19) = happyShift action_61
action_54 (20) = happyShift action_62
action_54 (21) = happyShift action_63
action_54 (22) = happyShift action_64
action_54 (23) = happyShift action_65
action_54 _ = happyReduce_22

action_55 (16) = happyShift action_58
action_55 (17) = happyShift action_59
action_55 (18) = happyShift action_60
action_55 (19) = happyShift action_61
action_55 (20) = happyShift action_62
action_55 (21) = happyShift action_63
action_55 (22) = happyShift action_64
action_55 (23) = happyShift action_65
action_55 _ = happyReduce_24

action_56 _ = happyReduce_21

action_57 (13) = happyShift action_30
action_57 (14) = happyShift action_31
action_57 (15) = happyShift action_32
action_57 (26) = happyShift action_33
action_57 (30) = happyShift action_34
action_57 (31) = happyShift action_35
action_57 (42) = happyShift action_36
action_57 (43) = happyShift action_37
action_57 (44) = happyShift action_38
action_57 (45) = happyShift action_39
action_57 (51) = happyShift action_40
action_57 (53) = happyShift action_41
action_57 (55) = happyShift action_42
action_57 (6) = happyGoto action_99
action_57 (7) = happyGoto action_26
action_57 (8) = happyGoto action_27
action_57 (9) = happyGoto action_28
action_57 (10) = happyGoto action_29
action_57 _ = happyFail (happyExpListPerState 57)

action_58 (13) = happyShift action_30
action_58 (14) = happyShift action_31
action_58 (15) = happyShift action_32
action_58 (26) = happyShift action_33
action_58 (30) = happyShift action_34
action_58 (31) = happyShift action_35
action_58 (42) = happyShift action_36
action_58 (43) = happyShift action_37
action_58 (44) = happyShift action_38
action_58 (45) = happyShift action_39
action_58 (51) = happyShift action_40
action_58 (53) = happyShift action_41
action_58 (55) = happyShift action_42
action_58 (6) = happyGoto action_98
action_58 (7) = happyGoto action_26
action_58 (8) = happyGoto action_27
action_58 (9) = happyGoto action_28
action_58 (10) = happyGoto action_29
action_58 _ = happyFail (happyExpListPerState 58)

action_59 (13) = happyShift action_30
action_59 (14) = happyShift action_31
action_59 (15) = happyShift action_32
action_59 (26) = happyShift action_33
action_59 (30) = happyShift action_34
action_59 (31) = happyShift action_35
action_59 (42) = happyShift action_36
action_59 (43) = happyShift action_37
action_59 (44) = happyShift action_38
action_59 (45) = happyShift action_39
action_59 (51) = happyShift action_40
action_59 (53) = happyShift action_41
action_59 (55) = happyShift action_42
action_59 (6) = happyGoto action_97
action_59 (7) = happyGoto action_26
action_59 (8) = happyGoto action_27
action_59 (9) = happyGoto action_28
action_59 (10) = happyGoto action_29
action_59 _ = happyFail (happyExpListPerState 59)

action_60 (13) = happyShift action_30
action_60 (14) = happyShift action_31
action_60 (15) = happyShift action_32
action_60 (26) = happyShift action_33
action_60 (30) = happyShift action_34
action_60 (31) = happyShift action_35
action_60 (42) = happyShift action_36
action_60 (43) = happyShift action_37
action_60 (44) = happyShift action_38
action_60 (45) = happyShift action_39
action_60 (51) = happyShift action_40
action_60 (53) = happyShift action_41
action_60 (55) = happyShift action_42
action_60 (6) = happyGoto action_96
action_60 (7) = happyGoto action_26
action_60 (8) = happyGoto action_27
action_60 (9) = happyGoto action_28
action_60 (10) = happyGoto action_29
action_60 _ = happyFail (happyExpListPerState 60)

action_61 (13) = happyShift action_30
action_61 (14) = happyShift action_31
action_61 (15) = happyShift action_32
action_61 (26) = happyShift action_33
action_61 (30) = happyShift action_34
action_61 (31) = happyShift action_35
action_61 (42) = happyShift action_36
action_61 (43) = happyShift action_37
action_61 (44) = happyShift action_38
action_61 (45) = happyShift action_39
action_61 (51) = happyShift action_40
action_61 (53) = happyShift action_41
action_61 (55) = happyShift action_42
action_61 (6) = happyGoto action_95
action_61 (7) = happyGoto action_26
action_61 (8) = happyGoto action_27
action_61 (9) = happyGoto action_28
action_61 (10) = happyGoto action_29
action_61 _ = happyFail (happyExpListPerState 61)

action_62 (13) = happyShift action_30
action_62 (14) = happyShift action_31
action_62 (15) = happyShift action_32
action_62 (26) = happyShift action_33
action_62 (30) = happyShift action_34
action_62 (31) = happyShift action_35
action_62 (42) = happyShift action_36
action_62 (43) = happyShift action_37
action_62 (44) = happyShift action_38
action_62 (45) = happyShift action_39
action_62 (51) = happyShift action_40
action_62 (53) = happyShift action_41
action_62 (55) = happyShift action_42
action_62 (6) = happyGoto action_94
action_62 (7) = happyGoto action_26
action_62 (8) = happyGoto action_27
action_62 (9) = happyGoto action_28
action_62 (10) = happyGoto action_29
action_62 _ = happyFail (happyExpListPerState 62)

action_63 (13) = happyShift action_30
action_63 (14) = happyShift action_31
action_63 (15) = happyShift action_32
action_63 (26) = happyShift action_33
action_63 (30) = happyShift action_34
action_63 (31) = happyShift action_35
action_63 (42) = happyShift action_36
action_63 (43) = happyShift action_37
action_63 (44) = happyShift action_38
action_63 (45) = happyShift action_39
action_63 (51) = happyShift action_40
action_63 (53) = happyShift action_41
action_63 (55) = happyShift action_42
action_63 (6) = happyGoto action_93
action_63 (7) = happyGoto action_26
action_63 (8) = happyGoto action_27
action_63 (9) = happyGoto action_28
action_63 (10) = happyGoto action_29
action_63 _ = happyFail (happyExpListPerState 63)

action_64 (13) = happyShift action_30
action_64 (14) = happyShift action_31
action_64 (15) = happyShift action_32
action_64 (26) = happyShift action_33
action_64 (30) = happyShift action_34
action_64 (31) = happyShift action_35
action_64 (42) = happyShift action_36
action_64 (43) = happyShift action_37
action_64 (44) = happyShift action_38
action_64 (45) = happyShift action_39
action_64 (51) = happyShift action_40
action_64 (53) = happyShift action_41
action_64 (55) = happyShift action_42
action_64 (6) = happyGoto action_92
action_64 (7) = happyGoto action_26
action_64 (8) = happyGoto action_27
action_64 (9) = happyGoto action_28
action_64 (10) = happyGoto action_29
action_64 _ = happyFail (happyExpListPerState 64)

action_65 (13) = happyShift action_30
action_65 (14) = happyShift action_31
action_65 (15) = happyShift action_32
action_65 (26) = happyShift action_33
action_65 (30) = happyShift action_34
action_65 (31) = happyShift action_35
action_65 (42) = happyShift action_36
action_65 (43) = happyShift action_37
action_65 (44) = happyShift action_38
action_65 (45) = happyShift action_39
action_65 (51) = happyShift action_40
action_65 (53) = happyShift action_41
action_65 (55) = happyShift action_42
action_65 (6) = happyGoto action_91
action_65 (7) = happyGoto action_26
action_65 (8) = happyGoto action_27
action_65 (9) = happyGoto action_28
action_65 (10) = happyGoto action_29
action_65 _ = happyFail (happyExpListPerState 65)

action_66 (13) = happyShift action_30
action_66 (14) = happyShift action_31
action_66 (15) = happyShift action_32
action_66 (26) = happyShift action_33
action_66 (30) = happyShift action_34
action_66 (31) = happyShift action_35
action_66 (42) = happyShift action_36
action_66 (43) = happyShift action_37
action_66 (44) = happyShift action_38
action_66 (45) = happyShift action_39
action_66 (51) = happyShift action_40
action_66 (53) = happyShift action_41
action_66 (55) = happyShift action_42
action_66 (6) = happyGoto action_90
action_66 (7) = happyGoto action_26
action_66 (8) = happyGoto action_27
action_66 (9) = happyGoto action_28
action_66 (10) = happyGoto action_29
action_66 _ = happyFail (happyExpListPerState 66)

action_67 (13) = happyShift action_30
action_67 (14) = happyShift action_31
action_67 (15) = happyShift action_32
action_67 (26) = happyShift action_33
action_67 (30) = happyShift action_34
action_67 (31) = happyShift action_35
action_67 (42) = happyShift action_36
action_67 (43) = happyShift action_37
action_67 (44) = happyShift action_38
action_67 (45) = happyShift action_39
action_67 (51) = happyShift action_40
action_67 (53) = happyShift action_41
action_67 (55) = happyShift action_42
action_67 (6) = happyGoto action_89
action_67 (7) = happyGoto action_26
action_67 (8) = happyGoto action_27
action_67 (9) = happyGoto action_28
action_67 (10) = happyGoto action_29
action_67 _ = happyFail (happyExpListPerState 67)

action_68 (13) = happyShift action_30
action_68 (14) = happyShift action_31
action_68 (15) = happyShift action_32
action_68 (26) = happyShift action_33
action_68 (30) = happyShift action_34
action_68 (31) = happyShift action_35
action_68 (42) = happyShift action_36
action_68 (43) = happyShift action_37
action_68 (44) = happyShift action_38
action_68 (45) = happyShift action_39
action_68 (51) = happyShift action_40
action_68 (53) = happyShift action_41
action_68 (55) = happyShift action_42
action_68 (6) = happyGoto action_88
action_68 (7) = happyGoto action_26
action_68 (8) = happyGoto action_27
action_68 (9) = happyGoto action_28
action_68 (10) = happyGoto action_29
action_68 _ = happyFail (happyExpListPerState 68)

action_69 (13) = happyShift action_30
action_69 (14) = happyShift action_31
action_69 (15) = happyShift action_32
action_69 (26) = happyShift action_33
action_69 (30) = happyShift action_34
action_69 (31) = happyShift action_35
action_69 (42) = happyShift action_36
action_69 (43) = happyShift action_37
action_69 (44) = happyShift action_38
action_69 (45) = happyShift action_39
action_69 (51) = happyShift action_40
action_69 (53) = happyShift action_41
action_69 (55) = happyShift action_42
action_69 (6) = happyGoto action_87
action_69 (7) = happyGoto action_26
action_69 (8) = happyGoto action_27
action_69 (9) = happyGoto action_28
action_69 (10) = happyGoto action_29
action_69 _ = happyFail (happyExpListPerState 69)

action_70 (13) = happyShift action_30
action_70 (14) = happyShift action_31
action_70 (15) = happyShift action_32
action_70 (26) = happyShift action_33
action_70 (30) = happyShift action_34
action_70 (31) = happyShift action_35
action_70 (42) = happyShift action_36
action_70 (43) = happyShift action_37
action_70 (44) = happyShift action_38
action_70 (45) = happyShift action_39
action_70 (51) = happyShift action_40
action_70 (53) = happyShift action_41
action_70 (55) = happyShift action_42
action_70 (6) = happyGoto action_86
action_70 (7) = happyGoto action_26
action_70 (8) = happyGoto action_27
action_70 (9) = happyGoto action_28
action_70 (10) = happyGoto action_29
action_70 _ = happyFail (happyExpListPerState 70)

action_71 (13) = happyShift action_30
action_71 (14) = happyShift action_31
action_71 (15) = happyShift action_32
action_71 (26) = happyShift action_33
action_71 (30) = happyShift action_34
action_71 (31) = happyShift action_35
action_71 (42) = happyShift action_36
action_71 (43) = happyShift action_37
action_71 (44) = happyShift action_38
action_71 (45) = happyShift action_39
action_71 (51) = happyShift action_40
action_71 (53) = happyShift action_41
action_71 (55) = happyShift action_42
action_71 (6) = happyGoto action_85
action_71 (7) = happyGoto action_26
action_71 (8) = happyGoto action_27
action_71 (9) = happyGoto action_28
action_71 (10) = happyGoto action_29
action_71 _ = happyFail (happyExpListPerState 71)

action_72 (13) = happyShift action_30
action_72 (14) = happyShift action_31
action_72 (15) = happyShift action_32
action_72 (26) = happyShift action_33
action_72 (30) = happyShift action_34
action_72 (31) = happyShift action_35
action_72 (42) = happyShift action_36
action_72 (43) = happyShift action_37
action_72 (44) = happyShift action_38
action_72 (45) = happyShift action_39
action_72 (51) = happyShift action_40
action_72 (53) = happyShift action_41
action_72 (55) = happyShift action_42
action_72 (6) = happyGoto action_84
action_72 (7) = happyGoto action_26
action_72 (8) = happyGoto action_27
action_72 (9) = happyGoto action_28
action_72 (10) = happyGoto action_29
action_72 _ = happyFail (happyExpListPerState 72)

action_73 (13) = happyShift action_30
action_73 (14) = happyShift action_31
action_73 (15) = happyShift action_32
action_73 (26) = happyShift action_33
action_73 (30) = happyShift action_34
action_73 (31) = happyShift action_35
action_73 (42) = happyShift action_36
action_73 (43) = happyShift action_37
action_73 (44) = happyShift action_38
action_73 (45) = happyShift action_39
action_73 (51) = happyShift action_40
action_73 (53) = happyShift action_41
action_73 (55) = happyShift action_42
action_73 (6) = happyGoto action_83
action_73 (7) = happyGoto action_26
action_73 (8) = happyGoto action_27
action_73 (9) = happyGoto action_28
action_73 (10) = happyGoto action_29
action_73 _ = happyFail (happyExpListPerState 73)

action_74 (13) = happyShift action_30
action_74 (14) = happyShift action_31
action_74 (15) = happyShift action_32
action_74 (26) = happyShift action_33
action_74 (30) = happyShift action_34
action_74 (31) = happyShift action_35
action_74 (42) = happyShift action_36
action_74 (43) = happyShift action_37
action_74 (44) = happyShift action_38
action_74 (45) = happyShift action_39
action_74 (51) = happyShift action_40
action_74 (53) = happyShift action_41
action_74 (55) = happyShift action_42
action_74 (6) = happyGoto action_82
action_74 (7) = happyGoto action_26
action_74 (8) = happyGoto action_27
action_74 (9) = happyGoto action_28
action_74 (10) = happyGoto action_29
action_74 _ = happyFail (happyExpListPerState 74)

action_75 (13) = happyShift action_30
action_75 (14) = happyShift action_31
action_75 (15) = happyShift action_32
action_75 (26) = happyShift action_33
action_75 (30) = happyShift action_34
action_75 (31) = happyShift action_35
action_75 (42) = happyShift action_36
action_75 (43) = happyShift action_37
action_75 (44) = happyShift action_38
action_75 (45) = happyShift action_39
action_75 (51) = happyShift action_40
action_75 (53) = happyShift action_41
action_75 (55) = happyShift action_42
action_75 (6) = happyGoto action_81
action_75 (7) = happyGoto action_26
action_75 (8) = happyGoto action_27
action_75 (9) = happyGoto action_28
action_75 (10) = happyGoto action_29
action_75 _ = happyFail (happyExpListPerState 75)

action_76 (13) = happyShift action_30
action_76 (14) = happyShift action_31
action_76 (15) = happyShift action_32
action_76 (26) = happyShift action_33
action_76 (30) = happyShift action_34
action_76 (31) = happyShift action_35
action_76 (42) = happyShift action_36
action_76 (43) = happyShift action_37
action_76 (44) = happyShift action_38
action_76 (45) = happyShift action_39
action_76 (51) = happyShift action_40
action_76 (53) = happyShift action_41
action_76 (55) = happyShift action_42
action_76 (6) = happyGoto action_80
action_76 (7) = happyGoto action_26
action_76 (8) = happyGoto action_27
action_76 (9) = happyGoto action_28
action_76 (10) = happyGoto action_29
action_76 _ = happyFail (happyExpListPerState 76)

action_77 _ = happyReduce_51

action_78 (56) = happyShift action_79
action_78 _ = happyFail (happyExpListPerState 78)

action_79 (46) = happyShift action_115
action_79 _ = happyFail (happyExpListPerState 79)

action_80 (16) = happyShift action_58
action_80 (17) = happyShift action_59
action_80 (18) = happyShift action_60
action_80 (19) = happyShift action_61
action_80 (20) = happyShift action_62
action_80 (21) = happyShift action_63
action_80 (22) = happyShift action_64
action_80 (23) = happyShift action_65
action_80 _ = happyReduce_43

action_81 (16) = happyShift action_58
action_81 (17) = happyShift action_59
action_81 (18) = happyShift action_60
action_81 (19) = happyShift action_61
action_81 (20) = happyShift action_62
action_81 (21) = happyShift action_63
action_81 (22) = happyShift action_64
action_81 (23) = happyShift action_65
action_81 _ = happyReduce_42

action_82 (16) = happyShift action_58
action_82 (17) = happyShift action_59
action_82 (18) = happyShift action_60
action_82 (19) = happyShift action_61
action_82 (20) = happyShift action_62
action_82 (21) = happyShift action_63
action_82 (22) = happyShift action_64
action_82 (23) = happyShift action_65
action_82 _ = happyReduce_41

action_83 (16) = happyShift action_58
action_83 (17) = happyShift action_59
action_83 (18) = happyShift action_60
action_83 (19) = happyShift action_61
action_83 (20) = happyShift action_62
action_83 (21) = happyShift action_63
action_83 (22) = happyShift action_64
action_83 (23) = happyShift action_65
action_83 _ = happyReduce_40

action_84 (16) = happyShift action_58
action_84 (17) = happyShift action_59
action_84 (18) = happyShift action_60
action_84 (19) = happyShift action_61
action_84 (20) = happyShift action_62
action_84 (21) = happyShift action_63
action_84 (22) = happyShift action_64
action_84 (23) = happyShift action_65
action_84 _ = happyReduce_39

action_85 (16) = happyShift action_58
action_85 (17) = happyShift action_59
action_85 (18) = happyShift action_60
action_85 (19) = happyShift action_61
action_85 (20) = happyShift action_62
action_85 (21) = happyShift action_63
action_85 (22) = happyShift action_64
action_85 (23) = happyShift action_65
action_85 _ = happyReduce_38

action_86 (16) = happyShift action_58
action_86 (17) = happyShift action_59
action_86 (18) = happyShift action_60
action_86 (19) = happyShift action_61
action_86 (20) = happyShift action_62
action_86 (21) = happyShift action_63
action_86 (22) = happyShift action_64
action_86 (23) = happyShift action_65
action_86 _ = happyReduce_37

action_87 (16) = happyShift action_58
action_87 (17) = happyShift action_59
action_87 (18) = happyShift action_60
action_87 (19) = happyShift action_61
action_87 (20) = happyShift action_62
action_87 (21) = happyShift action_63
action_87 (22) = happyShift action_64
action_87 (23) = happyShift action_65
action_87 (24) = happyShift action_66
action_87 (25) = happyShift action_67
action_87 (35) = happyShift action_70
action_87 (36) = happyShift action_71
action_87 (37) = happyShift action_72
action_87 (38) = happyShift action_73
action_87 (39) = happyShift action_74
action_87 (40) = happyShift action_75
action_87 (41) = happyShift action_76
action_87 _ = happyReduce_36

action_88 (16) = happyShift action_58
action_88 (17) = happyShift action_59
action_88 (18) = happyShift action_60
action_88 (19) = happyShift action_61
action_88 (20) = happyShift action_62
action_88 (21) = happyShift action_63
action_88 (22) = happyShift action_64
action_88 (23) = happyShift action_65
action_88 (24) = happyShift action_66
action_88 (25) = happyShift action_67
action_88 (35) = happyShift action_70
action_88 (36) = happyShift action_71
action_88 (37) = happyShift action_72
action_88 (38) = happyShift action_73
action_88 (39) = happyShift action_74
action_88 (40) = happyShift action_75
action_88 (41) = happyShift action_76
action_88 _ = happyReduce_35

action_89 (16) = happyShift action_58
action_89 (17) = happyShift action_59
action_89 (18) = happyShift action_60
action_89 (19) = happyShift action_61
action_89 (20) = happyShift action_62
action_89 (21) = happyShift action_63
action_89 (22) = happyShift action_64
action_89 (23) = happyShift action_65
action_89 (35) = happyShift action_70
action_89 (36) = happyShift action_71
action_89 (37) = happyShift action_72
action_89 (38) = happyShift action_73
action_89 (39) = happyShift action_74
action_89 (40) = happyShift action_75
action_89 (41) = happyShift action_76
action_89 _ = happyReduce_34

action_90 (16) = happyShift action_58
action_90 (17) = happyShift action_59
action_90 (18) = happyShift action_60
action_90 (19) = happyShift action_61
action_90 (20) = happyShift action_62
action_90 (21) = happyShift action_63
action_90 (22) = happyShift action_64
action_90 (23) = happyShift action_65
action_90 (35) = happyShift action_70
action_90 (36) = happyShift action_71
action_90 (37) = happyShift action_72
action_90 (38) = happyShift action_73
action_90 (39) = happyShift action_74
action_90 (40) = happyShift action_75
action_90 (41) = happyShift action_76
action_90 _ = happyReduce_33

action_91 (16) = happyShift action_58
action_91 (17) = happyShift action_59
action_91 (18) = happyShift action_60
action_91 (19) = happyShift action_61
action_91 (20) = happyShift action_62
action_91 _ = happyReduce_32

action_92 (16) = happyShift action_58
action_92 (17) = happyShift action_59
action_92 (18) = happyShift action_60
action_92 (19) = happyShift action_61
action_92 (20) = happyShift action_62
action_92 _ = happyReduce_31

action_93 (16) = happyShift action_58
action_93 (17) = happyShift action_59
action_93 (18) = happyShift action_60
action_93 (19) = happyShift action_61
action_93 (20) = happyShift action_62
action_93 (22) = happyShift action_64
action_93 (23) = happyShift action_65
action_93 _ = happyReduce_30

action_94 _ = happyReduce_29

action_95 _ = happyReduce_28

action_96 _ = happyReduce_27

action_97 (18) = happyShift action_60
action_97 (19) = happyShift action_61
action_97 (20) = happyShift action_62
action_97 _ = happyReduce_26

action_98 (18) = happyShift action_60
action_98 (19) = happyShift action_61
action_98 (20) = happyShift action_62
action_98 _ = happyReduce_25

action_99 (16) = happyShift action_58
action_99 (17) = happyShift action_59
action_99 (18) = happyShift action_60
action_99 (19) = happyShift action_61
action_99 (20) = happyShift action_62
action_99 (21) = happyShift action_63
action_99 (22) = happyShift action_64
action_99 (23) = happyShift action_65
action_99 (24) = happyShift action_66
action_99 (25) = happyShift action_67
action_99 (32) = happyShift action_68
action_99 (33) = happyShift action_69
action_99 (35) = happyShift action_70
action_99 (36) = happyShift action_71
action_99 (37) = happyShift action_72
action_99 (38) = happyShift action_73
action_99 (39) = happyShift action_74
action_99 (40) = happyShift action_75
action_99 (41) = happyShift action_76
action_99 (56) = happyShift action_114
action_99 _ = happyFail (happyExpListPerState 99)

action_100 (13) = happyShift action_30
action_100 (14) = happyShift action_31
action_100 (15) = happyShift action_32
action_100 (26) = happyShift action_33
action_100 (30) = happyShift action_34
action_100 (31) = happyShift action_35
action_100 (42) = happyShift action_36
action_100 (43) = happyShift action_37
action_100 (44) = happyShift action_38
action_100 (45) = happyShift action_39
action_100 (51) = happyShift action_40
action_100 (53) = happyShift action_41
action_100 (55) = happyShift action_42
action_100 (6) = happyGoto action_113
action_100 (7) = happyGoto action_26
action_100 (8) = happyGoto action_27
action_100 (9) = happyGoto action_28
action_100 (10) = happyGoto action_29
action_100 _ = happyFail (happyExpListPerState 100)

action_101 (13) = happyShift action_30
action_101 (14) = happyShift action_31
action_101 (15) = happyShift action_32
action_101 (26) = happyShift action_33
action_101 (30) = happyShift action_34
action_101 (31) = happyShift action_35
action_101 (42) = happyShift action_36
action_101 (43) = happyShift action_37
action_101 (44) = happyShift action_38
action_101 (45) = happyShift action_39
action_101 (51) = happyShift action_40
action_101 (53) = happyShift action_41
action_101 (55) = happyShift action_42
action_101 (6) = happyGoto action_112
action_101 (7) = happyGoto action_26
action_101 (8) = happyGoto action_27
action_101 (9) = happyGoto action_28
action_101 (10) = happyGoto action_29
action_101 _ = happyFail (happyExpListPerState 101)

action_102 (13) = happyShift action_30
action_102 (14) = happyShift action_31
action_102 (15) = happyShift action_32
action_102 (26) = happyShift action_33
action_102 (30) = happyShift action_34
action_102 (31) = happyShift action_35
action_102 (42) = happyShift action_36
action_102 (43) = happyShift action_37
action_102 (44) = happyShift action_38
action_102 (45) = happyShift action_39
action_102 (51) = happyShift action_40
action_102 (53) = happyShift action_41
action_102 (55) = happyShift action_42
action_102 (6) = happyGoto action_111
action_102 (7) = happyGoto action_26
action_102 (8) = happyGoto action_27
action_102 (9) = happyGoto action_28
action_102 (10) = happyGoto action_29
action_102 _ = happyFail (happyExpListPerState 102)

action_103 (13) = happyShift action_30
action_103 (14) = happyShift action_31
action_103 (15) = happyShift action_32
action_103 (26) = happyShift action_33
action_103 (30) = happyShift action_34
action_103 (31) = happyShift action_35
action_103 (42) = happyShift action_36
action_103 (43) = happyShift action_37
action_103 (44) = happyShift action_38
action_103 (45) = happyShift action_39
action_103 (51) = happyShift action_40
action_103 (53) = happyShift action_41
action_103 (55) = happyShift action_42
action_103 (6) = happyGoto action_110
action_103 (7) = happyGoto action_26
action_103 (8) = happyGoto action_27
action_103 (9) = happyGoto action_28
action_103 (10) = happyGoto action_29
action_103 _ = happyFail (happyExpListPerState 103)

action_104 (13) = happyShift action_30
action_104 (14) = happyShift action_31
action_104 (15) = happyShift action_32
action_104 (26) = happyShift action_33
action_104 (30) = happyShift action_34
action_104 (31) = happyShift action_35
action_104 (42) = happyShift action_36
action_104 (43) = happyShift action_37
action_104 (44) = happyShift action_38
action_104 (45) = happyShift action_39
action_104 (51) = happyShift action_40
action_104 (53) = happyShift action_41
action_104 (55) = happyShift action_42
action_104 (6) = happyGoto action_109
action_104 (7) = happyGoto action_26
action_104 (8) = happyGoto action_27
action_104 (9) = happyGoto action_28
action_104 (10) = happyGoto action_29
action_104 _ = happyFail (happyExpListPerState 104)

action_105 (13) = happyShift action_30
action_105 (14) = happyShift action_31
action_105 (15) = happyShift action_32
action_105 (26) = happyShift action_33
action_105 (30) = happyShift action_34
action_105 (31) = happyShift action_35
action_105 (42) = happyShift action_36
action_105 (43) = happyShift action_37
action_105 (44) = happyShift action_38
action_105 (45) = happyShift action_39
action_105 (51) = happyShift action_40
action_105 (53) = happyShift action_41
action_105 (55) = happyShift action_42
action_105 (5) = happyGoto action_108
action_105 (6) = happyGoto action_45
action_105 (7) = happyGoto action_26
action_105 (8) = happyGoto action_27
action_105 (9) = happyGoto action_28
action_105 (10) = happyGoto action_29
action_105 _ = happyFail (happyExpListPerState 105)

action_106 _ = happyReduce_16

action_107 _ = happyReduce_20

action_108 _ = happyReduce_4

action_109 (16) = happyShift action_58
action_109 (17) = happyShift action_59
action_109 (18) = happyShift action_60
action_109 (19) = happyShift action_61
action_109 (20) = happyShift action_62
action_109 (21) = happyShift action_63
action_109 (22) = happyShift action_64
action_109 (23) = happyShift action_65
action_109 (24) = happyShift action_66
action_109 (25) = happyShift action_67
action_109 (32) = happyShift action_68
action_109 (33) = happyShift action_69
action_109 (35) = happyShift action_70
action_109 (36) = happyShift action_71
action_109 (37) = happyShift action_72
action_109 (38) = happyShift action_73
action_109 (39) = happyShift action_74
action_109 (40) = happyShift action_75
action_109 (41) = happyShift action_76
action_109 (49) = happyShift action_119
action_109 (54) = happyShift action_120
action_109 _ = happyFail (happyExpListPerState 109)

action_110 (16) = happyShift action_58
action_110 (17) = happyShift action_59
action_110 (18) = happyShift action_60
action_110 (19) = happyShift action_61
action_110 (20) = happyShift action_62
action_110 (21) = happyShift action_63
action_110 (22) = happyShift action_64
action_110 (23) = happyShift action_65
action_110 (24) = happyShift action_66
action_110 (25) = happyShift action_67
action_110 (32) = happyShift action_68
action_110 (33) = happyShift action_69
action_110 (35) = happyShift action_70
action_110 (36) = happyShift action_71
action_110 (37) = happyShift action_72
action_110 (38) = happyShift action_73
action_110 (39) = happyShift action_74
action_110 (40) = happyShift action_75
action_110 (41) = happyShift action_76
action_110 (52) = happyShift action_118
action_110 _ = happyFail (happyExpListPerState 110)

action_111 (16) = happyShift action_58
action_111 (17) = happyShift action_59
action_111 (18) = happyShift action_60
action_111 (19) = happyShift action_61
action_111 (20) = happyShift action_62
action_111 (21) = happyShift action_63
action_111 (22) = happyShift action_64
action_111 (23) = happyShift action_65
action_111 (24) = happyShift action_66
action_111 (25) = happyShift action_67
action_111 (32) = happyShift action_68
action_111 (33) = happyShift action_69
action_111 (35) = happyShift action_70
action_111 (36) = happyShift action_71
action_111 (37) = happyShift action_72
action_111 (38) = happyShift action_73
action_111 (39) = happyShift action_74
action_111 (40) = happyShift action_75
action_111 (41) = happyShift action_76
action_111 _ = happyReduce_45

action_112 (16) = happyShift action_58
action_112 (17) = happyShift action_59
action_112 (18) = happyShift action_60
action_112 (19) = happyShift action_61
action_112 (20) = happyShift action_62
action_112 (21) = happyShift action_63
action_112 (22) = happyShift action_64
action_112 (23) = happyShift action_65
action_112 (24) = happyShift action_66
action_112 (25) = happyShift action_67
action_112 (32) = happyShift action_68
action_112 (33) = happyShift action_69
action_112 (35) = happyShift action_70
action_112 (36) = happyShift action_71
action_112 (37) = happyShift action_72
action_112 (38) = happyShift action_73
action_112 (39) = happyShift action_74
action_112 (40) = happyShift action_75
action_112 (41) = happyShift action_76
action_112 (50) = happyShift action_117
action_112 _ = happyReduce_46

action_113 (16) = happyShift action_58
action_113 (17) = happyShift action_59
action_113 (18) = happyShift action_60
action_113 (19) = happyShift action_61
action_113 (20) = happyShift action_62
action_113 (21) = happyShift action_63
action_113 (22) = happyShift action_64
action_113 (23) = happyShift action_65
action_113 (24) = happyShift action_66
action_113 (25) = happyShift action_67
action_113 (32) = happyShift action_68
action_113 (33) = happyShift action_69
action_113 (35) = happyShift action_70
action_113 (36) = happyShift action_71
action_113 (37) = happyShift action_72
action_113 (38) = happyShift action_73
action_113 (39) = happyShift action_74
action_113 (40) = happyShift action_75
action_113 (41) = happyShift action_76
action_113 _ = happyReduce_44

action_114 _ = happyReduce_19

action_115 (13) = happyShift action_30
action_115 (14) = happyShift action_31
action_115 (15) = happyShift action_32
action_115 (26) = happyShift action_33
action_115 (30) = happyShift action_34
action_115 (31) = happyShift action_35
action_115 (42) = happyShift action_36
action_115 (43) = happyShift action_37
action_115 (44) = happyShift action_38
action_115 (45) = happyShift action_39
action_115 (51) = happyShift action_40
action_115 (53) = happyShift action_41
action_115 (55) = happyShift action_42
action_115 (6) = happyGoto action_116
action_115 (7) = happyGoto action_26
action_115 (8) = happyGoto action_27
action_115 (9) = happyGoto action_28
action_115 (10) = happyGoto action_29
action_115 _ = happyFail (happyExpListPerState 115)

action_116 (16) = happyShift action_58
action_116 (17) = happyShift action_59
action_116 (18) = happyShift action_60
action_116 (19) = happyShift action_61
action_116 (20) = happyShift action_62
action_116 (21) = happyShift action_63
action_116 (22) = happyShift action_64
action_116 (23) = happyShift action_65
action_116 (24) = happyShift action_66
action_116 (25) = happyShift action_67
action_116 (32) = happyShift action_68
action_116 (33) = happyShift action_69
action_116 (35) = happyShift action_70
action_116 (36) = happyShift action_71
action_116 (37) = happyShift action_72
action_116 (38) = happyShift action_73
action_116 (39) = happyShift action_74
action_116 (40) = happyShift action_75
action_116 (41) = happyShift action_76
action_116 _ = happyReduce_2

action_117 (14) = happyShift action_51
action_117 (11) = happyGoto action_122
action_117 _ = happyFail (happyExpListPerState 117)

action_118 _ = happyReduce_14

action_119 (13) = happyShift action_30
action_119 (14) = happyShift action_31
action_119 (15) = happyShift action_32
action_119 (26) = happyShift action_33
action_119 (30) = happyShift action_34
action_119 (31) = happyShift action_35
action_119 (42) = happyShift action_36
action_119 (43) = happyShift action_37
action_119 (44) = happyShift action_38
action_119 (45) = happyShift action_39
action_119 (51) = happyShift action_40
action_119 (53) = happyShift action_41
action_119 (55) = happyShift action_42
action_119 (6) = happyGoto action_121
action_119 (7) = happyGoto action_26
action_119 (8) = happyGoto action_27
action_119 (9) = happyGoto action_28
action_119 (10) = happyGoto action_29
action_119 _ = happyFail (happyExpListPerState 119)

action_120 _ = happyReduce_17

action_121 (16) = happyShift action_58
action_121 (17) = happyShift action_59
action_121 (18) = happyShift action_60
action_121 (19) = happyShift action_61
action_121 (20) = happyShift action_62
action_121 (21) = happyShift action_63
action_121 (22) = happyShift action_64
action_121 (23) = happyShift action_65
action_121 (24) = happyShift action_66
action_121 (25) = happyShift action_67
action_121 (32) = happyShift action_68
action_121 (33) = happyShift action_69
action_121 (35) = happyShift action_70
action_121 (36) = happyShift action_71
action_121 (37) = happyShift action_72
action_121 (38) = happyShift action_73
action_121 (39) = happyShift action_74
action_121 (40) = happyShift action_75
action_121 (41) = happyShift action_76
action_121 (54) = happyShift action_123
action_121 _ = happyFail (happyExpListPerState 121)

action_122 _ = happyReduce_47

action_123 _ = happyReduce_18

happyReduce_1 = happyReduce 4 4 happyReduction_1
happyReduction_1 ((HappyAbsSyn6  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyTerminal happy_var_2) `HappyStk`
	(HappyAbsSyn12  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (VarAssStm happy_var_1 (text happy_var_2) happy_var_4 (tkPos happy_var_2)
	) `HappyStk` happyRest

happyReduce_2 = happyReduce 8 4 happyReduction_2
happyReduction_2 ((HappyAbsSyn6  happy_var_8) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyTerminal happy_var_5) `HappyStk`
	(HappyAbsSyn12  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyTerminal happy_var_2) `HappyStk`
	(HappyAbsSyn12  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (FunDeclStm happy_var_1 (text happy_var_2) happy_var_4 (text happy_var_5) happy_var_8 (tkPos happy_var_2)
	) `HappyStk` happyRest

happyReduce_3 = happySpecReduce_3  4 happyReduction_3
happyReduction_3 (HappyAbsSyn4  happy_var_3)
	_
	(HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn4
		 (CompoundStm happy_var_1 happy_var_3
	)
happyReduction_3 _ _ _  = notHappyAtAll 

happyReduce_4 = happySpecReduce_3  5 happyReduction_4
happyReduction_4 (HappyAbsSyn5  happy_var_3)
	_
	(HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn5
		 (ExpList happy_var_1 happy_var_3
	)
happyReduction_4 _ _ _  = notHappyAtAll 

happyReduce_5 = happySpecReduce_1  5 happyReduction_5
happyReduction_5 (HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn5
		 (SingleExp happy_var_1
	)
happyReduction_5 _  = notHappyAtAll 

happyReduce_6 = happySpecReduce_1  6 happyReduction_6
happyReduction_6 (HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn6
		 (happy_var_1
	)
happyReduction_6 _  = notHappyAtAll 

happyReduce_7 = happySpecReduce_1  6 happyReduction_7
happyReduction_7 (HappyAbsSyn8  happy_var_1)
	 =  HappyAbsSyn6
		 (happy_var_1
	)
happyReduction_7 _  = notHappyAtAll 

happyReduce_8 = happySpecReduce_1  6 happyReduction_8
happyReduction_8 (HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn6
		 (happy_var_1
	)
happyReduction_8 _  = notHappyAtAll 

happyReduce_9 = happySpecReduce_1  6 happyReduction_9
happyReduction_9 (HappyAbsSyn10  happy_var_1)
	 =  HappyAbsSyn6
		 (happy_var_1
	)
happyReduction_9 _  = notHappyAtAll 

happyReduce_10 = happySpecReduce_1  7 happyReduction_10
happyReduction_10 (HappyTerminal happy_var_1)
	 =  HappyAbsSyn7
		 (Int (value happy_var_1) (tkPos happy_var_1)
	)
happyReduction_10 _  = notHappyAtAll 

happyReduce_11 = happySpecReduce_1  7 happyReduction_11
happyReduction_11 (HappyTerminal happy_var_1)
	 =  HappyAbsSyn7
		 (Bool True (tkPos happy_var_1)
	)
happyReduction_11 _  = notHappyAtAll 

happyReduce_12 = happySpecReduce_1  7 happyReduction_12
happyReduction_12 (HappyTerminal happy_var_1)
	 =  HappyAbsSyn7
		 (Bool False (tkPos happy_var_1)
	)
happyReduction_12 _  = notHappyAtAll 

happyReduce_13 = happySpecReduce_1  7 happyReduction_13
happyReduction_13 (HappyTerminal happy_var_1)
	 =  HappyAbsSyn7
		 (Var (text happy_var_1) (tkPos happy_var_1)
	)
happyReduction_13 _  = notHappyAtAll 

happyReduce_14 = happyReduce 5 7 happyReduction_14
happyReduction_14 (_ `HappyStk`
	(HappyAbsSyn6  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn6  happy_var_2) `HappyStk`
	(HappyTerminal happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn7
		 (Pair happy_var_2 happy_var_4 (tkPos happy_var_1)
	) `HappyStk` happyRest

happyReduce_15 = happySpecReduce_2  7 happyReduction_15
happyReduction_15 _
	(HappyTerminal happy_var_1)
	 =  HappyAbsSyn7
		 (EmptySet (tkPos happy_var_1)
	)
happyReduction_15 _ _  = notHappyAtAll 

happyReduce_16 = happySpecReduce_3  7 happyReduction_16
happyReduction_16 _
	(HappyAbsSyn5  happy_var_2)
	(HappyTerminal happy_var_1)
	 =  HappyAbsSyn7
		 (SetExt happy_var_2 (tkPos happy_var_1)
	)
happyReduction_16 _ _ _  = notHappyAtAll 

happyReduce_17 = happyReduce 5 7 happyReduction_17
happyReduction_17 (_ `HappyStk`
	(HappyAbsSyn6  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn11  happy_var_2) `HappyStk`
	(HappyTerminal happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn7
		 (SetComp happy_var_2 happy_var_4 (tkPos happy_var_1)
	) `HappyStk` happyRest

happyReduce_18 = happyReduce 7 7 happyReduction_18
happyReduction_18 (_ `HappyStk`
	(HappyAbsSyn6  happy_var_6) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn6  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn11  happy_var_2) `HappyStk`
	(HappyTerminal happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn7
		 (SetCompFilter happy_var_2 happy_var_4 happy_var_6 (tkPos happy_var_1)
	) `HappyStk` happyRest

happyReduce_19 = happyReduce 4 7 happyReduction_19
happyReduction_19 (_ `HappyStk`
	(HappyAbsSyn6  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn7
		 (FunApp (text happy_var_1) happy_var_3 (tkPos happy_var_1)
	) `HappyStk` happyRest

happyReduce_20 = happySpecReduce_3  7 happyReduction_20
happyReduction_20 _
	(HappyAbsSyn6  happy_var_2)
	_
	 =  HappyAbsSyn7
		 (happy_var_2
	)
happyReduction_20 _ _ _  = notHappyAtAll 

happyReduce_21 = happySpecReduce_2  8 happyReduction_21
happyReduction_21 (HappyAbsSyn6  happy_var_2)
	(HappyTerminal happy_var_1)
	 =  HappyAbsSyn8
		 (UnOp Minus happy_var_2 (tkPos happy_var_1)
	)
happyReduction_21 _ _  = notHappyAtAll 

happyReduce_22 = happySpecReduce_2  8 happyReduction_22
happyReduction_22 (HappyAbsSyn6  happy_var_2)
	(HappyTerminal happy_var_1)
	 =  HappyAbsSyn8
		 (UnOp First happy_var_2 (tkPos happy_var_1)
	)
happyReduction_22 _ _  = notHappyAtAll 

happyReduce_23 = happySpecReduce_2  8 happyReduction_23
happyReduction_23 (HappyAbsSyn6  happy_var_2)
	(HappyTerminal happy_var_1)
	 =  HappyAbsSyn8
		 (UnOp Second happy_var_2 (tkPos happy_var_1)
	)
happyReduction_23 _ _  = notHappyAtAll 

happyReduce_24 = happySpecReduce_2  8 happyReduction_24
happyReduction_24 (HappyAbsSyn6  happy_var_2)
	(HappyTerminal happy_var_1)
	 =  HappyAbsSyn8
		 (UnOp Card happy_var_2 (tkPos happy_var_1)
	)
happyReduction_24 _ _  = notHappyAtAll 

happyReduce_25 = happySpecReduce_3  9 happyReduction_25
happyReduction_25 (HappyAbsSyn6  happy_var_3)
	_
	(HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn9
		 (BinOp Add happy_var_1 happy_var_3 (expFilePos happy_var_1)
	)
happyReduction_25 _ _ _  = notHappyAtAll 

happyReduce_26 = happySpecReduce_3  9 happyReduction_26
happyReduction_26 (HappyAbsSyn6  happy_var_3)
	_
	(HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn9
		 (BinOp Sub happy_var_1 happy_var_3 (expFilePos happy_var_1)
	)
happyReduction_26 _ _ _  = notHappyAtAll 

happyReduce_27 = happySpecReduce_3  9 happyReduction_27
happyReduction_27 (HappyAbsSyn6  happy_var_3)
	_
	(HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn9
		 (BinOp Mul happy_var_1 happy_var_3 (expFilePos happy_var_1)
	)
happyReduction_27 _ _ _  = notHappyAtAll 

happyReduce_28 = happySpecReduce_3  9 happyReduction_28
happyReduction_28 (HappyAbsSyn6  happy_var_3)
	_
	(HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn9
		 (BinOp Div happy_var_1 happy_var_3 (expFilePos happy_var_1)
	)
happyReduction_28 _ _ _  = notHappyAtAll 

happyReduce_29 = happySpecReduce_3  9 happyReduction_29
happyReduction_29 (HappyAbsSyn6  happy_var_3)
	_
	(HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn9
		 (BinOp Mod happy_var_1 happy_var_3 (expFilePos happy_var_1)
	)
happyReduction_29 _ _ _  = notHappyAtAll 

happyReduce_30 = happySpecReduce_3  9 happyReduction_30
happyReduction_30 (HappyAbsSyn6  happy_var_3)
	_
	(HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn9
		 (BinOp Range happy_var_1 happy_var_3 (expFilePos happy_var_1)
	)
happyReduction_30 _ _ _  = notHappyAtAll 

happyReduce_31 = happySpecReduce_3  9 happyReduction_31
happyReduction_31 (HappyAbsSyn6  happy_var_3)
	_
	(HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn9
		 (BinOp Lt happy_var_1 happy_var_3 (expFilePos happy_var_1)
	)
happyReduction_31 _ _ _  = notHappyAtAll 

happyReduce_32 = happySpecReduce_3  9 happyReduction_32
happyReduction_32 (HappyAbsSyn6  happy_var_3)
	_
	(HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn9
		 (BinOp Gt happy_var_1 happy_var_3 (expFilePos happy_var_1)
	)
happyReduction_32 _ _ _  = notHappyAtAll 

happyReduce_33 = happySpecReduce_3  9 happyReduction_33
happyReduction_33 (HappyAbsSyn6  happy_var_3)
	_
	(HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn9
		 (BinOp Eq happy_var_1 happy_var_3 (expFilePos happy_var_1)
	)
happyReduction_33 _ _ _  = notHappyAtAll 

happyReduce_34 = happySpecReduce_3  9 happyReduction_34
happyReduction_34 (HappyAbsSyn6  happy_var_3)
	_
	(HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn9
		 (BinOp NEq happy_var_1 happy_var_3 (expFilePos happy_var_1)
	)
happyReduction_34 _ _ _  = notHappyAtAll 

happyReduce_35 = happySpecReduce_3  9 happyReduction_35
happyReduction_35 (HappyAbsSyn6  happy_var_3)
	_
	(HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn9
		 (BinOp And happy_var_1 happy_var_3 (expFilePos happy_var_1)
	)
happyReduction_35 _ _ _  = notHappyAtAll 

happyReduce_36 = happySpecReduce_3  9 happyReduction_36
happyReduction_36 (HappyAbsSyn6  happy_var_3)
	_
	(HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn9
		 (BinOp Or happy_var_1 happy_var_3 (expFilePos happy_var_1)
	)
happyReduction_36 _ _ _  = notHappyAtAll 

happyReduce_37 = happySpecReduce_3  9 happyReduction_37
happyReduction_37 (HappyAbsSyn6  happy_var_3)
	_
	(HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn9
		 (BinOp Elem happy_var_1 happy_var_3 (expFilePos happy_var_1)
	)
happyReduction_37 _ _ _  = notHappyAtAll 

happyReduce_38 = happySpecReduce_3  9 happyReduction_38
happyReduction_38 (HappyAbsSyn6  happy_var_3)
	_
	(HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn9
		 (BinOp Subset happy_var_1 happy_var_3 (expFilePos happy_var_1)
	)
happyReduction_38 _ _ _  = notHappyAtAll 

happyReduce_39 = happySpecReduce_3  9 happyReduction_39
happyReduction_39 (HappyAbsSyn6  happy_var_3)
	_
	(HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn9
		 (BinOp SubsetEq happy_var_1 happy_var_3 (expFilePos happy_var_1)
	)
happyReduction_39 _ _ _  = notHappyAtAll 

happyReduce_40 = happySpecReduce_3  9 happyReduction_40
happyReduction_40 (HappyAbsSyn6  happy_var_3)
	_
	(HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn9
		 (BinOp Union happy_var_1 happy_var_3 (expFilePos happy_var_1)
	)
happyReduction_40 _ _ _  = notHappyAtAll 

happyReduce_41 = happySpecReduce_3  9 happyReduction_41
happyReduction_41 (HappyAbsSyn6  happy_var_3)
	_
	(HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn9
		 (BinOp Intersect happy_var_1 happy_var_3 (expFilePos happy_var_1)
	)
happyReduction_41 _ _ _  = notHappyAtAll 

happyReduce_42 = happySpecReduce_3  9 happyReduction_42
happyReduction_42 (HappyAbsSyn6  happy_var_3)
	_
	(HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn9
		 (BinOp Diff happy_var_1 happy_var_3 (expFilePos happy_var_1)
	)
happyReduction_42 _ _ _  = notHappyAtAll 

happyReduce_43 = happySpecReduce_3  9 happyReduction_43
happyReduction_43 (HappyAbsSyn6  happy_var_3)
	_
	(HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn9
		 (BinOp CartProduct happy_var_1 happy_var_3 (expFilePos happy_var_1)
	)
happyReduction_43 _ _ _  = notHappyAtAll 

happyReduce_44 = happyReduce 4 10 happyReduction_44
happyReduction_44 ((HappyAbsSyn6  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn11  happy_var_2) `HappyStk`
	(HappyTerminal happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn10
		 (Quant Exists happy_var_2 happy_var_4 (tkPos happy_var_1)
	) `HappyStk` happyRest

happyReduce_45 = happyReduce 4 10 happyReduction_45
happyReduction_45 ((HappyAbsSyn6  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn11  happy_var_2) `HappyStk`
	(HappyTerminal happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn10
		 (Quant ForAll happy_var_2 happy_var_4 (tkPos happy_var_1)
	) `HappyStk` happyRest

happyReduce_46 = happySpecReduce_3  11 happyReduction_46
happyReduction_46 (HappyAbsSyn6  happy_var_3)
	_
	(HappyTerminal happy_var_1)
	 =  HappyAbsSyn11
		 (SingleIt (text happy_var_1) happy_var_3
	)
happyReduction_46 _ _ _  = notHappyAtAll 

happyReduce_47 = happyReduce 5 11 happyReduction_47
happyReduction_47 ((HappyAbsSyn11  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn6  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn11
		 (IterList (text happy_var_1) happy_var_3 happy_var_5
	) `HappyStk` happyRest

happyReduce_48 = happySpecReduce_1  12 happyReduction_48
happyReduction_48 _
	 =  HappyAbsSyn12
		 (TInt
	)

happyReduce_49 = happySpecReduce_1  12 happyReduction_49
happyReduction_49 _
	 =  HappyAbsSyn12
		 (TBool
	)

happyReduce_50 = happyReduce 4 12 happyReduction_50
happyReduction_50 (_ `HappyStk`
	(HappyAbsSyn12  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn12
		 (TSet happy_var_3
	) `HappyStk` happyRest

happyReduce_51 = happyReduce 5 12 happyReduction_51
happyReduction_51 (_ `HappyStk`
	(HappyAbsSyn12  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn12  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn12
		 (TPair happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_52 = happySpecReduce_3  12 happyReduction_52
happyReduction_52 _
	(HappyAbsSyn12  happy_var_2)
	_
	 =  HappyAbsSyn12
		 (happy_var_2
	)
happyReduction_52 _ _ _  = notHappyAtAll 

happyNewToken action sts stk [] =
	action 57 57 notHappyAtAll (HappyState action) sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = action i i tk (HappyState action) sts stk tks in
	case tk of {
	TokenInt _  _ -> cont 13;
	TokenId _ _ -> cont 14;
	TokenNeg _ -> cont 15;
	TokenPlus _ -> cont 16;
	TokenMinus _ -> cont 17;
	TokenTimes _ -> cont 18;
	TokenDiv _ -> cont 19;
	TokenMod _ -> cont 20;
	TokenDots _ -> cont 21;
	TokenLt _ -> cont 22;
	TokenGt _ -> cont 23;
	TokenEq _ -> cont 24;
	TokenNEq _ -> cont 25;
	TokenCard _ -> cont 26;
	TokenTInt _ -> cont 27;
	TokenTBool _ -> cont 28;
	TokenTSet _ -> cont 29;
	TokenTrue _ -> cont 30;
	TokenFalse _ -> cont 31;
	TokenAnd _ -> cont 32;
	TokenOr _ -> cont 33;
	TokenIn _ -> cont 34;
	TokenElem _ -> cont 35;
	TokenSubset _ -> cont 36;
	TokenSubsetEq _ -> cont 37;
	TokenUnion _ -> cont 38;
	TokenIntersect _ -> cont 39;
	TokenDiff _ -> cont 40;
	TokenCartProduct _ -> cont 41;
	TokenFirst _ -> cont 42;
	TokenSecond _ -> cont 43;
	TokenExists _ -> cont 44;
	TokenForAll _ -> cont 45;
	TokenAss _ -> cont 46;
	TokenColon _ -> cont 47;
	TokenSemi _ -> cont 48;
	TokenPipe _ -> cont 49;
	TokenComma _ -> cont 50;
	TokenLBr _ -> cont 51;
	TokenRBr _ -> cont 52;
	TokenLCurlyBr _ -> cont 53;
	TokenRCurlyBr _ -> cont 54;
	TokenLParen _ -> cont 55;
	TokenRParen _ -> cont 56;
	_ -> happyError' ((tk:tks), [])
	}

happyError_ explist 57 tk tks = happyError' (tks, explist)
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
parse tks = happyRunIdentity happySomeParser where
 happySomeParser = happyThen (happyParse action_0 tks) (\x -> case x of {HappyAbsSyn4 z -> happyReturn z; _other -> notHappyAtAll })

happySeq = happyDontSeq


parseError :: [Token] -> a
parseError [] = error "Unknown Parse Error. Maybe at the end of the file?"
parseError (t : _) = error $ "Parse error " ++ (show . tkPos) t ++ "."
{-# LINE 1 "templates/GenericTemplate.hs" #-}
{-# LINE 1 "templates/GenericTemplate.hs" #-}
{-# LINE 1 "<built-in>" #-}
{-# LINE 1 "<command-line>" #-}
{-# LINE 8 "<command-line>" #-}
# 1 "/usr/include/stdc-predef.h" 1 3 4

# 17 "/usr/include/stdc-predef.h" 3 4














































{-# LINE 8 "<command-line>" #-}
{-# LINE 1 "/usr/lib/ghc/include/ghcversion.h" #-}

















{-# LINE 8 "<command-line>" #-}
{-# LINE 1 "/tmp/ghc8814_0/ghc_2.h" #-}




























































































































































{-# LINE 8 "<command-line>" #-}
{-# LINE 1 "templates/GenericTemplate.hs" #-}
-- Id: GenericTemplate.hs,v 1.26 2005/01/14 14:47:22 simonmar Exp 









{-# LINE 43 "templates/GenericTemplate.hs" #-}

data Happy_IntList = HappyCons Int Happy_IntList







{-# LINE 65 "templates/GenericTemplate.hs" #-}

{-# LINE 75 "templates/GenericTemplate.hs" #-}

{-# LINE 84 "templates/GenericTemplate.hs" #-}

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

{-# LINE 137 "templates/GenericTemplate.hs" #-}

{-# LINE 147 "templates/GenericTemplate.hs" #-}
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

{-# LINE 267 "templates/GenericTemplate.hs" #-}
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

{-# LINE 333 "templates/GenericTemplate.hs" #-}
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
