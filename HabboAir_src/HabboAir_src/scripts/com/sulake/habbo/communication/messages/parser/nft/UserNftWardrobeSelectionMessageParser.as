package com.sulake.habbo.communication.messages.parser.nft
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class UserNftWardrobeSelectionMessageParser implements IMessageParser
   {
      private var _currentTokenId:String;
      
      private var _fallbackFigureString:String;
      
      private var _fallbackFigureGender:String;
      
      public function UserNftWardrobeSelectionMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _fallbackFigureString = "";
         _fallbackFigureGender = "";
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _currentTokenId = param1.readString();
         _fallbackFigureString = param1.readString();
         _fallbackFigureGender = param1.readString();
         return true;
      }
      
      public function get currentTokenId() : String
      {
         return _currentTokenId;
      }
      
      public function get fallbackFigureString() : String
      {
         return _fallbackFigureString;
      }
      
      public function get fallbackFigureGender() : String
      {
         return _fallbackFigureGender;
      }
   }
}

