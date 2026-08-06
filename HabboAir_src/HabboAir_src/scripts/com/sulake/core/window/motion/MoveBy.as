package com.sulake.core.window.motion
{
   import com.sulake.core.window.IWindowModel;
   
   use namespace friend;
   
   public class MoveBy extends MoveTo
   {
      public function MoveBy(param1:IWindowModel, param2:int, param3:int, param4:int)
      {
         super(param1,param2,param3,param4);
      }
      
      override friend function start() : void
      {
         UnknownVarFromMoveTo_Number_3 = target.x + UnknownVarFromMoveTo_Number_3;
         UnknownVarFromMoveTo_Number_4 = target.y + UnknownVarFromMoveTo_Number_4;
         super.friend::start();
      }
   }
}

