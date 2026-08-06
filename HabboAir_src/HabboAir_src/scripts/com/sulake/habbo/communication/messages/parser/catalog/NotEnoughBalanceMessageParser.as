package com.sulake.habbo.communication.messages.parser.catalog
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class NotEnoughBalanceMessageParser implements IMessageParser
   {
      private var _notEnoughCredits:Boolean = false;
      
      private var _notEnoughActivityPoints:Boolean = false;
      
      private var _activityPointType:int = 0;
      
      public function NotEnoughBalanceMessageParser()
      {
         super();
      }
      
      public function get notEnoughCredits() : Boolean
      {
         return _notEnoughCredits;
      }
      
      public function get notEnoughActivityPoints() : Boolean
      {
         return _notEnoughActivityPoints;
      }
      
      public function get activityPointType() : int
      {
         return _activityPointType;
      }
      
      public function flush() : Boolean
      {
         _notEnoughCredits = false;
         _notEnoughActivityPoints = false;
         _activityPointType = 0;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _notEnoughCredits = param1.readBoolean();
         _notEnoughActivityPoints = param1.readBoolean();
         if(param1.bytesAvailable)
         {
            _activityPointType = param1.readInteger();
         }
         return true;
      }
   }
}

