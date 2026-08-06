package com.sulake.habbo.quest.rewardtrack.view.prizes
{
   import com.sulake.habbo.quest.rewardtrack.data.RewardTrack;
   import com.sulake.habbo.quest.rewardtrack.data.RewardTrackPrize;
   
   public class RewardTrackPrizeLayout
   {
      private static const PAGE_BOUNDARY_EPSILON:Number = 0.0001;
      
      private var _visibleWidth:int;
      
      private var _prizeWidth:int;
      
      private var UnknownVarFromRewardTrackPrizeLayout_Int_1:int;
      
      private var UnknownVarFromRewardTrackPrizeLayout_Number_1:Number;
      
      private var UnknownVarFromRewardTrackPrizeLayout_Number_2:Number;
      
      private var UnknownVarFromRewardTrackPrizeLayout_Int_2:int = 1;
      
      private var _distancePerPoint:Number = 1;
      
      private var _pageCount:int = 1;
      
      private var UnknownVarFromRewardTrackPrizeLayout_Int_3:int;
      
      public function RewardTrackPrizeLayout()
      {
         super();
      }
      
      public function rebuild(param1:RewardTrack, param2:int, param3:int, param4:int) : void
      {
         _visibleWidth = param2;
         _prizeWidth = param3;
         UnknownVarFromRewardTrackPrizeLayout_Int_1 = param4;
         UnknownVarFromRewardTrackPrizeLayout_Number_1 = _prizeWidth / 2 + UnknownVarFromRewardTrackPrizeLayout_Int_1;
         UnknownVarFromRewardTrackPrizeLayout_Int_3 = findMinRequiredPoints(param1.prizes);
         var _loc6_:int = findMinimumGap(param1.prizes);
         var _loc5_:int = findMaxRequiredPoints(param1.prizes);
         if(_loc6_ <= 0)
         {
            _loc6_ = Math.max(1,_loc5_);
         }
         _distancePerPoint = (_prizeWidth + UnknownVarFromRewardTrackPrizeLayout_Int_1) / _loc6_;
         if(_distancePerPoint <= 0)
         {
            _distancePerPoint = 1;
         }
         UnknownVarFromRewardTrackPrizeLayout_Int_2 = calculatePagePointSpan(_distancePerPoint,_loc6_);
         _distancePerPoint = findMaxDistancePerPoint(_distancePerPoint,UnknownVarFromRewardTrackPrizeLayout_Int_2);
         UnknownVarFromRewardTrackPrizeLayout_Number_2 = zeroOffsetFor(_distancePerPoint);
         _pageCount = calculatePageCount(param1.prizes);
      }
      
      public function xForPoints(param1:int, param2:int) : Number
      {
         var _loc3_:int = Math.max(0,param2 * UnknownVarFromRewardTrackPrizeLayout_Int_2);
         return UnknownVarFromRewardTrackPrizeLayout_Number_2 + (param1 - _loc3_) * _distancePerPoint;
      }
      
      public function pageForPoints(param1:int) : int
      {
         var _loc2_:int = pageForPointSpan(param1,UnknownVarFromRewardTrackPrizeLayout_Int_2);
         return Math.max(0,Math.min(_pageCount - 1,_loc2_));
      }
      
      private function calculatePageCount(param1:Vector.<RewardTrackPrize>) : int
      {
         var _loc2_:int = 0;
         for each(var _loc3_ in param1)
         {
            _loc2_ = Math.max(_loc2_,pageForPointSpan(_loc3_.requiredPoints,UnknownVarFromRewardTrackPrizeLayout_Int_2));
         }
         return Math.max(1,_loc2_ + 1);
      }
      
      private function pageForPointSpan(param1:int, param2:int) : int
      {
         if(param1 <= 0)
         {
            return 0;
         }
         return Math.max(0,int(Math.ceil((param1 - 0.0001) / param2)) - 1);
      }
      
      private function zeroOffsetFor(param1:Number) : Number
      {
         return Math.max(0,UnknownVarFromRewardTrackPrizeLayout_Number_1 - UnknownVarFromRewardTrackPrizeLayout_Int_3 * param1);
      }
      
      private function usableWidthFor(param1:Number) : Number
      {
         return Math.max(1,_visibleWidth - UnknownVarFromRewardTrackPrizeLayout_Number_1 - zeroOffsetFor(param1));
      }
      
      private function calculatePagePointSpan(param1:Number, param2:int) : int
      {
         var _loc3_:int = Math.max(1,int(Math.floor(usableWidthFor(param1) / param1 / param2)));
         return Math.max(1,_loc3_ * param2);
      }
      
      private function findMaxDistancePerPoint(param1:Number, param2:int) : Number
      {
         var _loc5_:int = 0;
         var _loc6_:Number = NaN;
         var _loc4_:* = param1;
         var _loc3_:* = param1;
         _loc5_ = 0;
         while(_loc5_ < 32)
         {
            _loc3_ *= 2;
            if(!pagePointSpanFits(_loc3_,param2))
            {
               break;
            }
            _loc4_ = _loc3_;
            _loc5_ += 1;
         }
         _loc5_ = 0;
         while(_loc5_ < 24)
         {
            _loc6_ = (_loc4_ + _loc3_) / 2;
            if(pagePointSpanFits(_loc6_,param2))
            {
               _loc4_ = _loc6_;
            }
            else
            {
               _loc3_ = _loc6_;
            }
            _loc5_ += 1;
         }
         return _loc4_;
      }
      
      private function pagePointSpanFits(param1:Number, param2:int) : Boolean
      {
         return param2 * param1 <= usableWidthFor(param1) + 0.0001;
      }
      
      private function findMinimumGap(param1:Vector.<RewardTrackPrize>) : int
      {
         var _loc3_:int = findMinimumGapForPremium(param1,false);
         var _loc2_:int = findMinimumGapForPremium(param1,true);
         if(_loc3_ <= 0)
         {
            return _loc2_;
         }
         if(_loc2_ <= 0)
         {
            return _loc3_;
         }
         return Math.min(_loc3_,_loc2_);
      }
      
      private function findMinimumGapForPremium(param1:Vector.<RewardTrackPrize>, param2:Boolean) : int
      {
         var _loc4_:int = 0;
         var _loc3_:int = -1;
         var _loc5_:* = 0;
         for each(var _loc6_ in param1)
         {
            if(_loc6_.premium == param2)
            {
               if(_loc3_ != -1)
               {
                  _loc4_ = _loc6_.requiredPoints - _loc3_;
                  if(_loc4_ > 0 && (_loc5_ == 0 || _loc4_ < _loc5_))
                  {
                     _loc5_ = _loc4_;
                  }
               }
               _loc3_ = _loc6_.requiredPoints;
            }
         }
         return _loc5_;
      }
      
      private function findMinRequiredPoints(param1:Vector.<RewardTrackPrize>) : int
      {
         var _loc2_:int = -1;
         for each(var _loc3_ in param1)
         {
            if(_loc2_ == -1 || _loc3_.requiredPoints < _loc2_)
            {
               _loc2_ = _loc3_.requiredPoints;
            }
         }
         return Math.max(0,_loc2_);
      }
      
      private function findMaxRequiredPoints(param1:Vector.<RewardTrackPrize>) : int
      {
         var _loc2_:int = 0;
         for each(var _loc3_ in param1)
         {
            _loc2_ = Math.max(_loc2_,_loc3_.requiredPoints);
         }
         return _loc2_;
      }
      
      public function get pageCount() : int
      {
         return _pageCount;
      }
      
      public function get distancePerPoint() : Number
      {
         return _distancePerPoint;
      }
   }
}

