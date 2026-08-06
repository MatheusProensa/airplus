package com.sulake.habbo.communication.messages.incoming.landingview
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class PromoArticleData
   {
      public static const UnknownConstFromPromoArticleData_Int_1:int = 0;
      
      public static const UnknownConstFromPromoArticleData_Int_2:int = 1;
      
      public static const UnknownConstFromPromoArticleData_Int_3:int = 2;
      
      private var _id:int;
      
      private var _title:String;
      
      private var _bodyText:String;
      
      private var _buttonText:String;
      
      private var _linkType:int;
      
      private var _linkContent:String;
      
      private var _imageUrl:String;
      
      public function PromoArticleData(param1:IMessageDataWrapper)
      {
         super();
         _id = param1.readInteger();
         _title = param1.readString();
         _bodyText = param1.readString();
         _buttonText = param1.readString();
         _linkType = param1.readInteger();
         _linkContent = param1.readString();
         _imageUrl = param1.readString();
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get title() : String
      {
         return _title;
      }
      
      public function get bodyText() : String
      {
         return _bodyText;
      }
      
      public function get buttonText() : String
      {
         return _buttonText;
      }
      
      public function get linkType() : int
      {
         return _linkType;
      }
      
      public function get linkContent() : String
      {
         return _linkContent;
      }
      
      public function get imageUrl() : String
      {
         return _imageUrl;
      }
   }
}

