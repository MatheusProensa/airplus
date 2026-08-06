package com.sulake.habbo.catalog.habbicons
{
   import flash.display.BitmapData;
   
   public class HabbiconSetModel
   {
      public var id:String;
      
      public var collectionId:int;
      
      public var name:String;
      
      public var title:String;
      
      public var description:String;
      
      public var UnknownVarFromHabbiconSetModel_BitmapData_1:BitmapData;
      
      public var habbicons:Vector.<HabbiconEntryModel> = new Vector.<HabbiconEntryModel>(0);
      
      public var rewardHabbicon:HabbiconEntryModel;
      
      public var completed:int = 0;
      
      public var total:int = 0;
      
      public var priceCredits:int = 0;
      
      public var priceActivityPoints:int = 0;
      
      public var activityPointType:int = 0;
      
      public var canBuy:Boolean = false;
      
      public function HabbiconSetModel()
      {
         super();
      }
      
      public function get complete() : Boolean
      {
         return total > 0 && completed >= total;
      }
      
      public function get progressRatio() : Number
      {
         return total <= 0 ? 0 : Math.max(0,Math.min(1,completed / total));
      }
   }
}

