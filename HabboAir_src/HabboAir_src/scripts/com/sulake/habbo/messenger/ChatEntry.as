package com.sulake.habbo.messenger
{
   import com.sulake.habbo.window.widgets.IlluminaChatBubbleMessage;
   import flash.utils.getTimer;
   
   public class ChatEntry
   {
      public static const TYPE_OWN_CHAT:int = 1;
      
      public static const TYPE_OTHER_CHAT:int = 2;
      
      public static const UnknownConstFromChatEntry_Int_1:int = 3;
      
      public static const TYPE_INFO:int = 4;
      
      public static const UnknownConstFromChatEntry_Int_2:int = 5;
      
      private var _type:int;
      
      private var _chatId:int;
      
      private var _message:IlluminaChatBubbleMessage;
      
      private var UnknownVarFromChatEntry_Int_1:int;
      
      private var _clientReceiveTime:int;
      
      private var _awaitConfirmationId:int;
      
      private var _messageId:String;
      
      private var _senderId:int;
      
      private var _senderName:String;
      
      private var _senderFigure:String;
      
      public function ChatEntry(param1:int, param2:int, param3:IlluminaChatBubbleMessage, param4:int, param5:int = 0, param6:String = null, param7:String = null, param8:String = "", param9:int = 0)
      {
         super();
         _type = param1;
         _chatId = param2;
         _message = param3;
         UnknownVarFromChatEntry_Int_1 = param4;
         _clientReceiveTime = getTimer();
         _awaitConfirmationId = param9;
         _messageId = param8;
         _senderId = param5;
         _senderName = param6;
         _senderFigure = param7;
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      public function get chatId() : int
      {
         return _chatId;
      }
      
      public function get message() : IlluminaChatBubbleMessage
      {
         return _message;
      }
      
      public function get messageText() : String
      {
         return _message.type == 0 ? _message.textValue : "";
      }
      
      public function get secondsSinceSent() : int
      {
         var _loc1_:int = (getTimer() - _clientReceiveTime) / 1000;
         return UnknownVarFromChatEntry_Int_1 + _loc1_;
      }
      
      public function sentTimeStamp() : Number
      {
         return new Date().getTime() - secondsSinceSent * 1000;
      }
      
      public function prefixMessageWith(param1:String) : void
      {
         if(_message.type == 0)
         {
            _message = IlluminaChatBubbleMessage.text(param1 + "\n" + messageText);
         }
      }
      
      public function get awaitConfirmationId() : int
      {
         return _awaitConfirmationId;
      }
      
      public function isAwaitingConfirmation() : Boolean
      {
         return _awaitConfirmationId != 0;
      }
      
      public function isConfirmed(param1:IlluminaChatBubbleMessage, param2:String) : void
      {
         _awaitConfirmationId = 0;
         _message = param1;
         _messageId = param2;
      }
      
      public function get messageId() : String
      {
         return _messageId;
      }
      
      public function get senderId() : int
      {
         return _senderId;
      }
      
      public function get senderName() : String
      {
         return _senderName;
      }
      
      public function get senderFigure() : String
      {
         return _senderFigure;
      }
   }
}

