package com.sulake.habbo.communication.messages.parser.competition
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class IsUserPartOfCompetitionMessageParser implements IMessageParser
   {
      private var _isPartOf:Boolean;
      
      private var _targetId:int;
      
      public function IsUserPartOfCompetitionMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _isPartOf = param1.readBoolean();
         _targetId = param1.readInteger();
         return true;
      }
      
      public function get isPartOf() : Boolean
      {
         return _isPartOf;
      }
      
      public function get targetId() : int
      {
         return _targetId;
      }
   }
}

