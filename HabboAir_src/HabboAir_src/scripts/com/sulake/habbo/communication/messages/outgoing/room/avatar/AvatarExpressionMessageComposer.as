package com.sulake.habbo.communication.messages.outgoing.room.avatar
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class AvatarExpressionMessageComposer implements IMessageComposer
   {
      private var _typeCode:int = 0;
      
      public function AvatarExpressionMessageComposer(param1:int)
      {
         super();
         _typeCode = param1;
      }
      
      public function dispose() : void
      {
         _typeCode = 0;
      }
      
      public function getMessageArray() : Array
      {
         return [_typeCode];
      }
   }
}

