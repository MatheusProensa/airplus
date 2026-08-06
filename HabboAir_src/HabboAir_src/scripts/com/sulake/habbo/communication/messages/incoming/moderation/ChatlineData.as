package com.sulake.habbo.communication.messages.incoming.moderation
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class ChatlineData
   {
      private var _timeStamp:String;
      
      private var _chatterId:int;
      
      private var _chatterName:String;
      
      private var _msg:String;
      
      private var _hasHighlighting:Boolean;
      
      public function ChatlineData(param1:IMessageDataWrapper)
      {
         super();
         _timeStamp = param1.readString();
         _chatterId = param1.readInteger();
         _chatterName = param1.readString();
         _msg = param1.readString();
         _hasHighlighting = param1.readBoolean();
      }
      
      public function get timeStamp() : String
      {
         return _timeStamp;
      }
      
      public function get chatterId() : int
      {
         return _chatterId;
      }
      
      public function get chatterName() : String
      {
         return _chatterName;
      }
      
      public function get msg() : String
      {
         return _msg;
      }
      
      public function get hasHighlighting() : Boolean
      {
         return _hasHighlighting;
      }
   }
}

