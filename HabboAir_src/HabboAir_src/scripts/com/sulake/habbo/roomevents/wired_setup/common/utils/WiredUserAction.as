package com.sulake.habbo.roomevents.wired_setup.common.utils
{
   public class WiredUserAction
   {
      public static const allWiredUserActions:Vector.<WiredUserAction> = new <WiredUserAction>[new WiredUserAction("wave",0),new WiredUserAction("blow",1),new WiredUserAction("laugh",2),new WiredUserAction("respect",3),new WiredUserAction("awake",4),new WiredUserAction("sleep",5),new WiredUserAction("sit",6),new WiredUserAction("stand",7),new WiredUserAction("lay",8),new WiredUserAction("sign",10,true,function(param1:int):String
      {
         return param1.toString();
      },function(param1:String):int
      {
         return int(param1);
      }),new WiredUserAction("dance",11,true,function(param1:int):String
      {
         return "dance " + param1;
      },function(param1:String):int
      {
         return int(param1.split(" ")[1]);
      }),new WiredUserAction("67",67)];
      
      private var _name:String;
      
      private var _code:int;
      
      private var _hasExtra:Boolean;
      
      private var _extraIdToString:Function;
      
      private var UnknownVarFromWiredUserAction_Function_1:Function;
      
      public function WiredUserAction(param1:String, param2:int, param3:Boolean = false, param4:Function = null, param5:Function = null)
      {
         super();
         _name = param1;
         _code = param2;
         _hasExtra = param3;
         _extraIdToString = param4;
         UnknownVarFromWiredUserAction_Function_1 = param5;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get code() : int
      {
         return _code;
      }
      
      public function get hasExtra() : Boolean
      {
         return _hasExtra;
      }
      
      public function convertCodeToExtraString(param1:int) : String
      {
         return _extraIdToString(param1);
      }
      
      public function convertExtraStringToCode(param1:String) : int
      {
         return UnknownVarFromWiredUserAction_Function_1(param1);
      }
   }
}

