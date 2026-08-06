package com.sulake.habbo.communication.messages.parser.room.chat
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class ChatMessageParser implements IMessageParser
   {
      private var _userId:int = 0;
      
      private var _text:String = "";
      
      private var _links:Array;
      
      private var _gesture:int = 0;
      
      private var _trackingId:int = -1;
      
      private var _styleId:int = 0;
      
      public function ChatMessageParser()
      {
         super();
      }
      
      public function get userId() : int
      {
         return _userId;
      }
      
      public function get text() : String
      {
         return _text;
      }
      
      public function get links() : Array
      {
         return _links;
      }
      
      public function get gesture() : int
      {
         return _gesture;
      }
      
      public function get trackingId() : int
      {
         return _trackingId;
      }
      
      public function get styleId() : int
      {
         return _styleId;
      }
      
      public function flush() : Boolean
      {
         _userId = 0;
         _text = "";
         _gesture = 0;
         _links = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc3_:int = 0;
         if(param1 == null)
         {
            return false;
         }
         _userId = param1.readInteger();
         _text = param1.readString();
         _gesture = param1.readInteger();
         _styleId = param1.readInteger();
         var _loc2_:int = param1.readInteger();
         if(_loc2_ > 0)
         {
            _links = [];
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               _links.push([param1.readString(),param1.readString(),param1.readBoolean()]);
               _loc3_++;
            }
         }
         _trackingId = param1.readInteger();
         return true;
      }
   }
}

