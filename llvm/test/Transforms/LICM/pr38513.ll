; RUN: opt -disable-basic-aa -alias-set-saturation-threshold=2 -passes='loop-mssa(licm)' -S < %s | FileCheck %s
; REQUIRES: asserts

; CHECK-LABEL: @f1(i1 %arg)
define void @f1(i1 %arg) {
  %lc1.10 = alloca [3 x i16]
  br label %bb1

bb1:                                              ; preds = %bb6, %0
  store i16 undef, ptr undef
  br label %bb2

bb2:                                              ; preds = %bb8, %bb1
  %_tmp18.fca.0.load = load i16, ptr %lc1.10
  %_tmp18.fca.1.gep = getelementptr inbounds [3 x i16], ptr %lc1.10, i32 0, i32 1
  %_tmp18.fca.1.load = load i16, ptr %_tmp18.fca.1.gep
  %_tmp18.fca.2.gep = getelementptr inbounds [3 x i16], ptr %lc1.10, i32 0, i32 2
  %_tmp18.fca.2.load = load i16, ptr %_tmp18.fca.2.gep
  br label %bb8

bb8:                                              ; preds = %bb2
  br i1 %arg, label %bb2, label %bb6

bb6:                                              ; preds = %bb8
  br label %bb1
}
