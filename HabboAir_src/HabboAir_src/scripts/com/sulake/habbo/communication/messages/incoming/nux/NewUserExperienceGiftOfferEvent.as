package com.sulake.habbo.communication.messages.incoming.nux
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.nux.NewUserExperienceGiftOfferParser;
   
   [SecureSWF(rename="true")]
   public class NewUserExperienceGiftOfferEvent extends MessageEvent implements IMessageEvent
   {
      public function NewUserExperienceGiftOfferEvent(param1:Function)
      {
         super(param1,NewUserExperienceGiftOfferParser);
      }
      
      public function getParser() : NewUserExperienceGiftOfferParser
      {
         return _parser as NewUserExperienceGiftOfferParser;
      }
   }
}

