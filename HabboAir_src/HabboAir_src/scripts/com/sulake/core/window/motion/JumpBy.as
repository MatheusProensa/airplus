package com.sulake.core.window.motion
{
   import com.sulake.core.window.IWindowModel;
   
   use namespace friend;
   
   public class JumpBy extends Interval
   {
      protected var UnknownVarFromJumpBy_Int_1:int;
      
      protected var UnknownVarFromJumpBy_Int_2:int;
      
      protected var UnknownVarFromJumpBy_Number_1:Number;
      
      protected var UnknownVarFromJumpBy_Number_2:Number;
      
      protected var UnknownVarFromJumpBy_Number_3:Number;
      
      protected var UnknownVarFromJumpBy_Int_3:int;
      
      public function JumpBy(param1:IWindowModel, param2:int, param3:int, param4:int, param5:int, param6:int)
      {
         super(param1,param2);
         UnknownVarFromJumpBy_Number_1 = param3;
         UnknownVarFromJumpBy_Number_2 = param4;
         UnknownVarFromJumpBy_Number_3 = -param5;
         UnknownVarFromJumpBy_Int_3 = param6;
      }
      
      override friend function start() : void
      {
         super.friend::start();
         UnknownVarFromJumpBy_Int_1 = target.x;
         UnknownVarFromJumpBy_Int_2 = target.y;
      }
      
      override friend function update(param1:Number) : void
      {
         super.friend::update(param1);
         target.x = UnknownVarFromJumpBy_Int_1 + UnknownVarFromJumpBy_Number_1 * param1;
         target.y = UnknownVarFromJumpBy_Int_2 + UnknownVarFromJumpBy_Number_3 * Math.abs(Math.sin(param1 * 3.141592653589793 * UnknownVarFromJumpBy_Int_3)) + UnknownVarFromJumpBy_Number_2 * param1;
      }
   }
}

