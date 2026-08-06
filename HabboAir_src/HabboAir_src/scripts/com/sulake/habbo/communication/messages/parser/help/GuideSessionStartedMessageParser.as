package com.sulake.habbo.communication.messages.parser.help
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class GuideSessionStartedMessageParser implements IMessageParser
   {
      private var _requesterUserId:int;
      
      private var _requesterName:String;
      
      private var _requesterFigure:String;
      
      private var _guideUserId:int;
      
      private var _guideName:String;
      
      private var _guideFigure:String;
      
      public function GuideSessionStartedMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _requesterUserId = param1.readInteger();
         _requesterName = param1.readString();
         _requesterFigure = param1.readString();
         _guideUserId = param1.readInteger();
         _guideName = param1.readString();
         _guideFigure = param1.readString();
         return true;
      }
      
      public function get requesterUserId() : int
      {
         return _requesterUserId;
      }
      
      public function get requesterName() : String
      {
         return _requesterName;
      }
      
      public function get requesterFigure() : String
      {
         return _requesterFigure;
      }
      
      public function get guideUserId() : int
      {
         return _guideUserId;
      }
      
      public function get guideName() : String
      {
         return _guideName;
      }
      
      public function get guideFigure() : String
      {
         return _guideFigure;
      }
   }
}

