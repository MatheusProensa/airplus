package com.sulake.habbo.communication.messages.parser.campaign
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class CampaignCalendarData
   {
      private var _campaignName:String;
      
      private var _campaignImage:String;
      
      private var _currentDay:int;
      
      private var _campaignDays:int;
      
      private var _openedDays:Vector.<int>;
      
      private var _missedDays:Vector.<int>;
      
      public function CampaignCalendarData()
      {
         super();
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         _campaignName = param1.readString();
         _campaignImage = param1.readString();
         _currentDay = param1.readInteger();
         _campaignDays = param1.readInteger();
         _openedDays = new Vector.<int>(0);
         _loc2_ = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _openedDays.push(param1.readInteger());
            _loc3_++;
         }
         _missedDays = new Vector.<int>(0);
         _loc2_ = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _missedDays.push(param1.readInteger());
            _loc3_++;
         }
         return true;
      }
      
      public function clone() : CampaignCalendarData
      {
         var _loc1_:CampaignCalendarData = new CampaignCalendarData();
         _loc1_.campaignDays = _campaignDays;
         _loc1_.campaignImage = _campaignImage;
         _loc1_.campaignName = _campaignName;
         _loc1_.currentDay = _currentDay;
         _loc1_.missedDays = _missedDays;
         _loc1_.openedDays = _openedDays;
         return _loc1_;
      }
      
      public function get campaignName() : String
      {
         return _campaignName;
      }
      
      public function get campaignImage() : String
      {
         return _campaignImage;
      }
      
      public function get currentDay() : int
      {
         return _currentDay;
      }
      
      public function get campaignDays() : int
      {
         return _campaignDays;
      }
      
      public function get openedDays() : Vector.<int>
      {
         return _openedDays;
      }
      
      public function get missedDays() : Vector.<int>
      {
         return _missedDays;
      }
      
      public function set campaignName(param1:String) : void
      {
         _campaignName = param1;
      }
      
      public function set campaignImage(param1:String) : void
      {
         _campaignImage = param1;
      }
      
      public function set currentDay(param1:int) : void
      {
         _currentDay = param1;
      }
      
      public function set campaignDays(param1:int) : void
      {
         _campaignDays = param1;
      }
      
      public function set openedDays(param1:Vector.<int>) : void
      {
         _openedDays = param1;
      }
      
      public function set missedDays(param1:Vector.<int>) : void
      {
         _missedDays = param1;
      }
   }
}

