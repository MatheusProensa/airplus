package com.sulake.habbo.communication.messages.parser.nux
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.nux.NewUserExperienceGiftOptions;
   
   [SecureSWF(rename="true")]
   public class NewUserExperienceGiftOfferParser implements IMessageParser
   {
      private var _giftOptions:Vector.<NewUserExperienceGiftOptions>;
      
      public function NewUserExperienceGiftOfferParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:int = param1.readInteger();
         _giftOptions = new Vector.<NewUserExperienceGiftOptions>();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _giftOptions.push(new NewUserExperienceGiftOptions(param1));
            _loc3_++;
         }
         return true;
      }
      
      public function get giftOptions() : Vector.<NewUserExperienceGiftOptions>
      {
         return _giftOptions;
      }
   }
}

