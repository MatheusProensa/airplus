package com.sulake.habbo.catalog.targetedoffers.data
{
   public class HabboMallOffer
   {
      private var _targetedOfferId:int;
      
      private var _identifier:String;
      
      private var _title:String;
      
      private var _highlight:String;
      
      private var _description:String;
      
      private var _imageUrl:String;
      
      private var _smallImageUrl:String;
      
      private var _trackingState:int;
      
      public function HabboMallOffer(param1:Object)
      {
         super();
         _targetedOfferId = parseInt(param1.targetedOfferId);
         _identifier = param1.identifier;
         _title = param1.header;
         _highlight = param1.highlight;
         _description = param1.description;
         _imageUrl = param1.imageUrl;
         _smallImageUrl = param1.smallImageUrl;
         _trackingState = parseInt(param1.trackingStateCode);
      }
      
      public function get targetedOfferId() : int
      {
         return _targetedOfferId;
      }
      
      public function get identifier() : String
      {
         return _identifier;
      }
      
      public function get title() : String
      {
         return _title;
      }
      
      public function get highlight() : String
      {
         return _highlight;
      }
      
      public function get description() : String
      {
         return _description;
      }
      
      public function get imageUrl() : String
      {
         return _imageUrl;
      }
      
      public function get smallImageUrl() : String
      {
         return _smallImageUrl;
      }
      
      public function get trackingState() : int
      {
         return _trackingState;
      }
   }
}

