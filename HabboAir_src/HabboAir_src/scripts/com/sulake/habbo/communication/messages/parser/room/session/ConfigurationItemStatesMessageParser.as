package com.sulake.habbo.communication.messages.parser.room.session
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class ConfigurationItemStatesMessageParser implements IMessageParser
   {
      private var _isHanditemControlBlocked:Boolean = false;
      
      private var _chooserDisabled:Boolean = false;
      
      private var _freeFurniMovementsEnabled:Boolean = false;
      
      private var _invisibleFurni:Boolean = false;
      
      public function ConfigurationItemStatesMessageParser()
      {
         super();
      }
      
      public function get isHanditemControlBlocked() : Boolean
      {
         return _isHanditemControlBlocked;
      }
      
      public function get chooserDisabled() : Boolean
      {
         return _chooserDisabled;
      }
      
      public function get freeFurniMovementsEnabled() : Boolean
      {
         return _freeFurniMovementsEnabled;
      }
      
      public function get invisibleFurni() : Boolean
      {
         return _invisibleFurni;
      }
      
      public function flush() : Boolean
      {
         _isHanditemControlBlocked = false;
         _chooserDisabled = false;
         _freeFurniMovementsEnabled = false;
         _invisibleFurni = false;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _isHanditemControlBlocked = param1.readBoolean();
         if(param1.bytesAvailable > 0)
         {
            _chooserDisabled = param1.readBoolean();
         }
         if(param1.bytesAvailable > 0)
         {
            _freeFurniMovementsEnabled = param1.readBoolean();
         }
         if(param1.bytesAvailable > 0)
         {
            _invisibleFurni = param1.readBoolean();
         }
         return true;
      }
   }
}

