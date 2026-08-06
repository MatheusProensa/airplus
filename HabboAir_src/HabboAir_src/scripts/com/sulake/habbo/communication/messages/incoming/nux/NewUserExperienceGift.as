package com.sulake.habbo.communication.messages.incoming.nux
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class NewUserExperienceGift
   {
      private var _productOfferList:Vector.<NewUserExperienceGiftProduct>;
      
      private var _thumbnailUrl:String;
      
      public function NewUserExperienceGift(param1:IMessageDataWrapper)
      {
         var _loc3_:int = 0;
         super();
         _thumbnailUrl = param1.readString();
         if(_thumbnailUrl == "")
         {
            _thumbnailUrl = null;
         }
         _productOfferList = new Vector.<NewUserExperienceGiftProduct>();
         var _loc2_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _productOfferList.push(new NewUserExperienceGiftProduct(param1));
            _loc3_++;
         }
      }
      
      public function get productOfferList() : Vector.<NewUserExperienceGiftProduct>
      {
         return _productOfferList;
      }
      
      public function get thumbnailUrl() : String
      {
         return _thumbnailUrl;
      }
   }
}

