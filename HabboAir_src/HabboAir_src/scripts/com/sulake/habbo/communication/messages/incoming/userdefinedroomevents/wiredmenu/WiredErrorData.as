package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredmenu
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class WiredErrorData
   {
      private var _errorId:int;
      
      private var _errorName:String;
      
      private var _category:String;
      
      private var _throwCount:int;
      
      private var _msSinceLastOccurrence:Number;
      
      public function WiredErrorData(param1:IMessageDataWrapper)
      {
         super();
         _errorId = param1.readInteger();
         _errorName = param1.readString();
         _category = param1.readString();
         _throwCount = param1.readInteger();
         _msSinceLastOccurrence = param1.readLong();
      }
      
      public function get errorId() : int
      {
         return _errorId;
      }
      
      public function get errorName() : String
      {
         return _errorName;
      }
      
      public function get category() : String
      {
         return _category;
      }
      
      public function get throwCount() : int
      {
         return _throwCount;
      }
      
      public function get msSinceLastOccurrence() : Number
      {
         return _msSinceLastOccurrence;
      }
   }
}

