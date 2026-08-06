package com.sulake.habbo.communication.messages.outgoing.handshake
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.communication.messages.IPreEncryptionMessage;
   import flash.system.Capabilities;
   
   [SecureSWF(rename="true")]
   public class ClientHelloMessageComposer implements IMessageComposer, IPreEncryptionMessage
   {
      private var UnknownVarFromClientHelloMessageComposer_String_1:String = "FLASH29";
      
      public function ClientHelloMessageComposer()
      {
         super();
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         var _loc2_:String = "WIN63-202607011411-782849652";
         var _loc1_:int = 0;
         if(Capabilities.os.indexOf("Windows") >= 0)
         {
            _loc1_ = 6;
         }
         else if(Capabilities.os.indexOf("Mac") >= 0)
         {
            _loc1_ = 5;
         }
         else if(Capabilities.os.indexOf("Linux") >= 0)
         {
            _loc1_ = 7;
         }
         return new Array(_loc2_,UnknownVarFromClientHelloMessageComposer_String_1,_loc1_,4);
      }
   }
}

