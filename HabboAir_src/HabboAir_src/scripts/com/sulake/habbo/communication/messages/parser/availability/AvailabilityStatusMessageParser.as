package com.sulake.habbo.communication.messages.parser.availability
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class AvailabilityStatusMessageParser implements IMessageParser
   {
      private var _isOpen:Boolean;
      
      private var _onShutDown:Boolean;
      
      private var _isAuthenticHabbo:Boolean;
      
      public function AvailabilityStatusMessageParser()
      {
         super();
      }
      
      public function get isOpen() : Boolean
      {
         return _isOpen;
      }
      
      public function get onShutDown() : Boolean
      {
         return _onShutDown;
      }
      
      public function get isAuthenticHabbo() : Boolean
      {
         return _isAuthenticHabbo;
      }
      
      public function flush() : Boolean
      {
         _isOpen = false;
         _onShutDown = false;
         _isAuthenticHabbo = false;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _isOpen = param1.readBoolean();
         _onShutDown = param1.readBoolean();
         if(param1.bytesAvailable)
         {
            _isAuthenticHabbo = param1.readBoolean();
         }
         return true;
      }
   }
}

