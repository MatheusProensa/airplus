package com.sulake.core.window.motion
{
   import com.sulake.core.window.IWindowModel;
   
   use namespace friend;
   
   public class MoveTo extends Interval
   {
      protected var UnknownVarFromMoveTo_Number_1:Number;
      
      protected var UnknownVarFromMoveTo_Number_2:Number;
      
      protected var UnknownVarFromMoveTo_Number_3:Number;
      
      protected var UnknownVarFromMoveTo_Number_4:Number;
      
      protected var UnknownVarFromMoveTo_Number_5:Number;
      
      protected var UnknownVarFromMoveTo_Number_6:Number;
      
      public function MoveTo(param1:IWindowModel, param2:int, param3:int, param4:int)
      {
         super(param1,param2);
         UnknownVarFromMoveTo_Number_3 = param3;
         UnknownVarFromMoveTo_Number_4 = param4;
      }
      
      override friend function start() : void
      {
         super.friend::start();
         UnknownVarFromMoveTo_Number_1 = target.x;
         UnknownVarFromMoveTo_Number_2 = target.y;
         UnknownVarFromMoveTo_Number_5 = UnknownVarFromMoveTo_Number_3 - UnknownVarFromMoveTo_Number_1;
         UnknownVarFromMoveTo_Number_6 = UnknownVarFromMoveTo_Number_4 - UnknownVarFromMoveTo_Number_2;
      }
      
      override friend function update(param1:Number) : void
      {
         target.x = UnknownVarFromMoveTo_Number_1 + UnknownVarFromMoveTo_Number_5 * param1;
         target.y = UnknownVarFromMoveTo_Number_2 + UnknownVarFromMoveTo_Number_6 * param1;
      }
   }
}

