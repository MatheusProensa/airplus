package com.sulake.habbo.communication.messages.outgoing.inventory.avatareffect
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class AvatarEffectActivatedComposer implements IMessageComposer
   {
      private var UnknownVarFromAvatarEffectActivatedComposer_Int_1:int;
      
      public function AvatarEffectActivatedComposer(param1:int)
      {
         super();
         UnknownVarFromAvatarEffectActivatedComposer_Int_1 = param1;
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         var _loc1_:Array = [];
         _loc1_.push(UnknownVarFromAvatarEffectActivatedComposer_Int_1);
         return _loc1_;
      }
   }
}

