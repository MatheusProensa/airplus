package com.sulake.habbo.communication.messages.parser.friendlist
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.friendlist.InstantMessageContentData;
   
   [SecureSWF(rename="true")]
   public class NewConsoleMessageMessageParser implements IMessageParser
   {
      private var UnknownVarFromNewConsoleMessageMessageParser_Number_1:Number;
      
      private var _content:InstantMessageContentData;
      
      private var _secondsSinceSent:int;
      
      private var _messageId:String;
      
      private var _confirmationId:int;
      
      private var _senderId:Number;
      
      private var _senderName:String;
      
      private var _senderFigure:String;
      
      public function NewConsoleMessageMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         this.UnknownVarFromNewConsoleMessageMessageParser_Number_1 = param1.readInteger();
         this._content = InstantMessageContentData.parse(param1);
         this._secondsSinceSent = param1.readInteger();
         this._messageId = param1.readString();
         this._confirmationId = param1.readInteger();
         this._senderId = param1.readInteger();
         this._senderName = param1.readString();
         this._senderFigure = param1.readString();
         return true;
      }
      
      public function get chatId() : Number
      {
         return this.UnknownVarFromNewConsoleMessageMessageParser_Number_1;
      }
      
      public function get messageText() : String
      {
         return this._content != null ? this._content.messageText : "";
      }
      
      public function get secondsSinceSent() : int
      {
         return _secondsSinceSent;
      }
      
      public function get messageType() : int
      {
         return _content != null ? _content.messageType : 0;
      }
      
      public function get habbiconId() : int
      {
         return _content != null ? _content.habbiconId : 0;
      }
      
      public function get content() : InstantMessageContentData
      {
         return _content;
      }
      
      public function get messageId() : String
      {
         return _messageId;
      }
      
      public function get confirmationId() : int
      {
         return _confirmationId;
      }
      
      public function get senderId() : Number
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

