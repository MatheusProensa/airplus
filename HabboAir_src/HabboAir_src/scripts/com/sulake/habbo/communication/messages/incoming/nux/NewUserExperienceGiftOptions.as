package com.sulake.habbo.communication.messages.incoming.nux
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class NewUserExperienceGiftOptions
   {
      private var _dayIndex:int;
      
      private var _stepIndex:int;
      
      private var _options:Vector.<NewUserExperienceGift>;
      
      public function NewUserExperienceGiftOptions(param1:IMessageDataWrapper)
      {
         var _loc2_:int = 0;
         super();
         _dayIndex = param1.readInteger();
         _stepIndex = param1.readInteger();
         _options = new Vector.<NewUserExperienceGift>(0);
         var _loc3_:int = param1.readInteger();
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _options.push(new NewUserExperienceGift(param1));
            _loc2_++;
         }
      }
      
      public function get dayIndex() : int
      {
         return _dayIndex;
      }
      
      public function get stepIndex() : int
      {
         return _stepIndex;
      }
      
      public function get options() : Vector.<NewUserExperienceGift>
      {
         return _options;
      }
   }
}

