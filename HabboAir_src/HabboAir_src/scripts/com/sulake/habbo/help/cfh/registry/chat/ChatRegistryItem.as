package com.sulake.habbo.help.cfh.registry.chat
{
   public class ChatRegistryItem
   {
      private var _userId:int;
      
      private var _userName:String = "";
      
      private var _text:String = "";
      
      private var _roomId:int;
      
      private var _roomName:String = "";
      
      private var _selected:Boolean;
      
      private var _index:uint;
      
      private var _chatTime:Date;
      
      public function ChatRegistryItem(param1:uint, param2:int, param3:String, param4:int, param5:String, param6:String)
      {
         super();
         _index = param1;
         _roomId = param2;
         _roomName = param3;
         _userId = param4;
         _userName = param5;
         _text = param6;
         _selected = false;
         _chatTime = new Date();
      }
      
      public function get userId() : int
      {
         return _userId;
      }
      
      public function get userName() : String
      {
         return _userName;
      }
      
      public function get text() : String
      {
         return _text;
      }
      
      public function get roomId() : int
      {
         return _roomId;
      }
      
      public function get roomName() : String
      {
         return _roomName;
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      public function set selected(param1:Boolean) : void
      {
         _selected = param1;
      }
      
      public function get index() : int
      {
         return _index;
      }
      
      public function get chatTime() : Date
      {
         return _chatTime;
      }
   }
}

