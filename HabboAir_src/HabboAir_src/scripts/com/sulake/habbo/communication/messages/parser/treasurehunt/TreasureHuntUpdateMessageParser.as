package com.sulake.habbo.communication.messages.parser.treasurehunt
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class TreasureHuntUpdateMessageParser implements IMessageParser
   {
      private var _huntId:String;
      
      private var _stepsCompleted:int;
      
      private var _totalSteps:int;
      
      private var _isCompleted:Boolean;
      
      public function TreasureHuntUpdateMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _huntId = null;
         _stepsCompleted = 0;
         _totalSteps = 0;
         _isCompleted = false;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _huntId = param1.readString();
         _stepsCompleted = param1.readInteger();
         _totalSteps = param1.readInteger();
         _isCompleted = param1.readBoolean();
         return true;
      }
      
      public function get huntId() : String
      {
         return _huntId;
      }
      
      public function get stepsCompleted() : int
      {
         return _stepsCompleted;
      }
      
      public function get totalSteps() : int
      {
         return _totalSteps;
      }
      
      public function get isCompleted() : Boolean
      {
         return _isCompleted;
      }
   }
}

