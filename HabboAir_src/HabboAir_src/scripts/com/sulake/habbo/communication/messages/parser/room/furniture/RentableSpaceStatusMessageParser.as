package com.sulake.habbo.communication.messages.parser.room.furniture
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class RentableSpaceStatusMessageParser implements IMessageParser
   {
      private var _rented:Boolean;
      
      private var _renterId:int;
      
      private var _renterName:String;
      
      private var _canRent:Boolean;
      
      private var _canRentErrorCode:int;
      
      private var _timeRemaining:int;
      
      private var _price:int;
      
      public function RentableSpaceStatusMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _rented = param1.readBoolean();
         _canRentErrorCode = param1.readInteger();
         _canRent = _canRentErrorCode === 0;
         _renterId = param1.readInteger();
         _renterName = param1.readString();
         _timeRemaining = param1.readInteger();
         _price = param1.readInteger();
         if(!_rented)
         {
            _renterId = -1;
            _renterName = "";
         }
         return true;
      }
      
      public function get rented() : Boolean
      {
         return _rented;
      }
      
      public function get renterId() : int
      {
         return _renterId;
      }
      
      public function get renterName() : String
      {
         return _renterName;
      }
      
      public function get canRent() : Boolean
      {
         return _canRent;
      }
      
      public function get price() : int
      {
         return _price;
      }
      
      public function get timeRemaining() : int
      {
         return _timeRemaining;
      }
      
      public function get canRentErrorCode() : int
      {
         return _canRentErrorCode;
      }
   }
}

