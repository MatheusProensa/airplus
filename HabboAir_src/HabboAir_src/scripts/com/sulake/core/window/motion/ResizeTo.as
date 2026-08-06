package com.sulake.core.window.motion
{
   import com.sulake.core.window.IWindowModel;
   
   use namespace friend;
   
   public class ResizeTo extends Interval
   {
      protected var UnknownVarFromResizeTo_Number_1:Number;
      
      protected var UnknownVarFromResizeTo_Number_2:Number;
      
      protected var UnknownVarFromResizeTo_Number_3:Number;
      
      protected var UnknownVarFromResizeTo_Number_4:Number;
      
      protected var UnknownVarFromResizeTo_Number_5:Number;
      
      protected var UnknownVarFromResizeTo_Number_6:Number;
      
      public function ResizeTo(param1:IWindowModel, param2:int, param3:int, param4:int)
      {
         super(param1,param2);
         UnknownVarFromResizeTo_Number_3 = param3;
         UnknownVarFromResizeTo_Number_4 = param4;
      }
      
      override friend function start() : void
      {
         super.friend::start();
         UnknownVarFromResizeTo_Number_1 = target.width;
         UnknownVarFromResizeTo_Number_2 = target.height;
         UnknownVarFromResizeTo_Number_5 = UnknownVarFromResizeTo_Number_3 - UnknownVarFromResizeTo_Number_1;
         UnknownVarFromResizeTo_Number_6 = UnknownVarFromResizeTo_Number_4 - UnknownVarFromResizeTo_Number_2;
      }
      
      override friend function update(param1:Number) : void
      {
         target.width = UnknownVarFromResizeTo_Number_1 + UnknownVarFromResizeTo_Number_5 * param1;
         target.height = UnknownVarFromResizeTo_Number_2 + UnknownVarFromResizeTo_Number_6 * param1;
      }
   }
}

