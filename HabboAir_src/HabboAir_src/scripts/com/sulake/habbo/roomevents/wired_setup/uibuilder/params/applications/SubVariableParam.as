package com.sulake.habbo.roomevents.wired_setup.uibuilder.params.applications
{
   public class SubVariableParam
   {
      private var _id:int;
      
      private var _name:String;
      
      private var _hasExtraText:Boolean;
      
      public function SubVariableParam(param1:int, param2:String, param3:Boolean = false)
      {
         super();
         _id = param1;
         _name = param2;
         _hasExtraText = param3;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get hasExtraText() : Boolean
      {
         return _hasExtraText;
      }
   }
}

