package com.sulake.habbo.communication.messages.parser.treasurehunt
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class TreasureHuntFailMessageParser implements IMessageParser
   {
      private var _huntId:String;
      
      private var _requiredLevel:int;
      
      private var _requiredLevelPaying:int;
      
      public function TreasureHuntFailMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _huntId = null;
         _requiredLevel = 0;
         _requiredLevelPaying = 0;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _huntId = param1.readString();
         _requiredLevel = param1.readInteger();
         _requiredLevelPaying = param1.readInteger();
         return true;
      }
      
      public function get huntId() : String
      {
         return _huntId;
      }
      
      public function get requiredLevel() : int
      {
         return _requiredLevel;
      }
      
      public function get requiredLevelPaying() : int
      {
         return _requiredLevelPaying;
      }
   }
}

