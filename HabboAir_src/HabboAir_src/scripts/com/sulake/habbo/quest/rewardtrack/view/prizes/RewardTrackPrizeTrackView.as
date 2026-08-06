package com.sulake.habbo.quest.rewardtrack.view.prizes
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.utils.WindowUtils;
   import com.sulake.habbo.quest.rewardtrack.RewardTrackController;
   import com.sulake.habbo.quest.rewardtrack.data.RewardTrack;
   import com.sulake.habbo.quest.rewardtrack.data.RewardTrackPrize;
   import com.sulake.habbo.quest.rewardtrack.view.progress.RewardTrackMainProgressBarView;
   import flash.utils.Dictionary;
   
   public class RewardTrackPrizeTrackView implements IComponentInterfaceQueue
   {
      private static const MIN_PRIZE_SPACING:int = 15;
      
      private var UnknownVarFromRewardTrackPrizeTrackView_RewardTrackController_1:RewardTrackController;
      
      private var UnknownVarFromRewardTrackPrizeTrackView_RewardTrack_1:RewardTrack;
      
      private var _content:IWindowController_1;
      
      private var UnknownVarFromRewardTrackPrizeTrackView_IWindowController_1_1:IWindowController_1;
      
      private var UnknownVarFromRewardTrackPrizeTrackView_IWindowController_1_2:IWindowController_1;
      
      private var UnknownVarFromRewardTrackPrizeTrackView_IWindowController_1_3:IWindowController_1;
      
      private var UnknownVarFromRewardTrackPrizeTrackView_IWindowController_1_4:IWindowController_1;
      
      private var UnknownVarFromRewardTrackPrizeTrackView_IWindowController_1_5:IWindowController_1;
      
      private var UnknownVarFromRewardTrackPrizeTrackView_IRegionWindow_1:IRegionWindow;
      
      private var UnknownVarFromRewardTrackPrizeTrackView_IRegionWindow_2:IRegionWindow;
      
      private var UnknownVarFromRewardTrackPrizeTrackView_IWindowController_1_6:IWindowController_1;
      
      private var UnknownVarFromRewardTrackPrizeTrackView_IWindowController_1_7:IWindowController_1;
      
      private var _layout:RewardTrackPrizeLayout;
      
      private var UnknownVarFromRewardTrackPrizeTrackView_RewardTrackMainProgressBarView_1:RewardTrackMainProgressBarView;
      
      private var UnknownVarFromRewardTrackPrizeTrackView_Vector_1:Vector.<RewardTrackPrizeView>;
      
      private var UnknownVarFromRewardTrackPrizeTrackView_Vector_2:Vector.<RewardTrackPrizeView>;
      
      private var UnknownVarFromRewardTrackPrizeTrackView_Vector_3:Vector.<RewardTrackPrizeView>;
      
      private var UnknownVarFromRewardTrackPrizeTrackView_Vector_4:Vector.<RewardTrackPointIndicatorView>;
      
      private var _freePagePrizes:Vector.<Vector.<RewardTrackPrize>>;
      
      private var _premiumPagePrizes:Vector.<Vector.<RewardTrackPrize>>;
      
      private var _pagePointValues:Vector.<Vector.<int>>;
      
      private var UnknownVarFromRewardTrackPrizeTrackView_Int_1:int;
      
      private var _disposed:Boolean;
      
      public function RewardTrackPrizeTrackView(param1:RewardTrackController, param2:RewardTrack, param3:IWindowController_1, param4:IWindowController_1, param5:IWindowController_1, param6:IWindowController_1, param7:IWindowController_1, param8:IWindowController_1, param9:IRegionWindow, param10:IRegionWindow, param11:IWindowController_1, param12:IWindowController_1)
      {
         super();
         UnknownVarFromRewardTrackPrizeTrackView_RewardTrackController_1 = param1;
         UnknownVarFromRewardTrackPrizeTrackView_RewardTrack_1 = param2;
         _content = param3;
         UnknownVarFromRewardTrackPrizeTrackView_IWindowController_1_1 = param4;
         UnknownVarFromRewardTrackPrizeTrackView_IWindowController_1_2 = param5;
         UnknownVarFromRewardTrackPrizeTrackView_IWindowController_1_3 = param6;
         UnknownVarFromRewardTrackPrizeTrackView_IWindowController_1_4 = param7;
         UnknownVarFromRewardTrackPrizeTrackView_IWindowController_1_5 = param8;
         UnknownVarFromRewardTrackPrizeTrackView_IRegionWindow_1 = param9;
         UnknownVarFromRewardTrackPrizeTrackView_IRegionWindow_2 = param10;
         UnknownVarFromRewardTrackPrizeTrackView_IWindowController_1_6 = param11;
         UnknownVarFromRewardTrackPrizeTrackView_IWindowController_1_7 = param12;
         _layout = new RewardTrackPrizeLayout();
         UnknownVarFromRewardTrackPrizeTrackView_RewardTrackMainProgressBarView_1 = new RewardTrackMainProgressBarView(UnknownVarFromRewardTrackPrizeTrackView_IWindowController_1_2);
         UnknownVarFromRewardTrackPrizeTrackView_Vector_1 = new Vector.<RewardTrackPrizeView>();
         UnknownVarFromRewardTrackPrizeTrackView_Vector_2 = new Vector.<RewardTrackPrizeView>();
         UnknownVarFromRewardTrackPrizeTrackView_Vector_3 = new Vector.<RewardTrackPrizeView>();
         UnknownVarFromRewardTrackPrizeTrackView_Vector_4 = new Vector.<RewardTrackPointIndicatorView>();
         UnknownVarFromRewardTrackPrizeTrackView_IRegionWindow_1.addEventListener("WME_CLICK",onPreviousClicked);
         UnknownVarFromRewardTrackPrizeTrackView_IRegionWindow_2.addEventListener("WME_CLICK",onNextClicked);
         refresh(false,true);
      }
      
      public function refresh(param1:Boolean, param2:Boolean) : void
      {
         _layout.rebuild(UnknownVarFromRewardTrackPrizeTrackView_RewardTrack_1,_content.width,UnknownVarFromRewardTrackPrizeTrackView_IWindowController_1_3.width,15);
         buildPageData();
         ensurePrizeSlots(UnknownVarFromRewardTrackPrizeTrackView_Vector_1,UnknownVarFromRewardTrackPrizeTrackView_IWindowController_1_3,maxPrizeCount(_freePagePrizes));
         ensurePrizeSlots(UnknownVarFromRewardTrackPrizeTrackView_Vector_2,UnknownVarFromRewardTrackPrizeTrackView_IWindowController_1_4,maxPrizeCount(_premiumPagePrizes));
         ensurePointIndicatorSlots(maxPointIndicatorCount());
         if(param2)
         {
            UnknownVarFromRewardTrackPrizeTrackView_Int_1 = _layout.pageForPoints(UnknownVarFromRewardTrackPrizeTrackView_RewardTrack_1.points);
         }
         UnknownVarFromRewardTrackPrizeTrackView_Int_1 = Math.max(0,Math.min(_layout.pageCount - 1,UnknownVarFromRewardTrackPrizeTrackView_Int_1));
         refreshPage(param1);
      }
      
      public function pointsUpdated(param1:Boolean) : void
      {
         refreshPrizeStates();
         refreshPointIndicators();
         UnknownVarFromRewardTrackPrizeTrackView_RewardTrackMainProgressBarView_1.refreshByX(_layout.xForPoints(UnknownVarFromRewardTrackPrizeTrackView_RewardTrack_1.points,UnknownVarFromRewardTrackPrizeTrackView_Int_1),param1);
         refreshUnclaimedIndicators();
      }
      
      public function prizeClaimed(param1:RewardTrackPrize) : void
      {
         var _loc2_:RewardTrackPrizeView = getPrizeView(param1);
         if(_loc2_ != null)
         {
            _loc2_.refreshState();
         }
         else
         {
            refreshPrizeStates();
         }
         refreshUnclaimedIndicators();
      }
      
      public function premiumUpdated(param1:Boolean) : void
      {
         pointsUpdated(param1);
      }
      
      public function update(param1:uint) : void
      {
         UnknownVarFromRewardTrackPrizeTrackView_RewardTrackMainProgressBarView_1.update(param1);
      }
      
      private function buildPageData() : void
      {
         var _loc1_:int = 0;
         var _loc2_:* = undefined;
         _freePagePrizes = createPrizePageData();
         _premiumPagePrizes = createPrizePageData();
         _pagePointValues = createPointPageData();
         var _loc3_:Vector.<Dictionary> = new Vector.<Dictionary>();
         _loc1_ = 0;
         while(_loc1_ < _layout.pageCount)
         {
            _loc3_.push(new Dictionary());
            _loc1_ += 1;
         }
         for each(var _loc4_ in UnknownVarFromRewardTrackPrizeTrackView_RewardTrack_1.prizes)
         {
            _loc1_ = _layout.pageForPoints(_loc4_.requiredPoints);
            _loc2_ = _loc4_.premium ? _premiumPagePrizes : _freePagePrizes;
            _loc2_[_loc1_].push(_loc4_);
            if(!_loc3_[_loc1_][_loc4_.requiredPoints])
            {
               _loc3_[_loc1_][_loc4_.requiredPoints] = true;
               _pagePointValues[_loc1_].push(_loc4_.requiredPoints);
            }
         }
      }
      
      private function createPrizePageData() : Vector.<Vector.<RewardTrackPrize>>
      {
         var _loc2_:int = 0;
         var _loc1_:Vector.<Vector.<RewardTrackPrize>> = new Vector.<Vector.<RewardTrackPrize>>();
         _loc2_ = 0;
         while(_loc2_ < _layout.pageCount)
         {
            _loc1_.push(new Vector.<RewardTrackPrize>());
            _loc2_ += 1;
         }
         return _loc1_;
      }
      
      private function createPointPageData() : Vector.<Vector.<int>>
      {
         var _loc2_:int = 0;
         var _loc1_:Vector.<Vector.<int>> = new Vector.<Vector.<int>>();
         _loc2_ = 0;
         while(_loc2_ < _layout.pageCount)
         {
            _loc1_.push(new Vector.<int>());
            _loc2_ += 1;
         }
         return _loc1_;
      }
      
      private function ensurePrizeSlots(param1:Vector.<RewardTrackPrizeView>, param2:IWindowController_1, param3:int) : void
      {
         var _loc4_:RewardTrackPrizeView = null;
         while(param1.length < param3)
         {
            _loc4_ = new RewardTrackPrizeView(param2);
            _loc4_.window.visible = false;
            _content.addChild(_loc4_.window);
            param1.push(_loc4_);
            UnknownVarFromRewardTrackPrizeTrackView_Vector_3.push(_loc4_);
         }
      }
      
      private function ensurePointIndicatorSlots(param1:int) : void
      {
         var _loc2_:RewardTrackPointIndicatorView = null;
         while(UnknownVarFromRewardTrackPrizeTrackView_Vector_4.length < param1)
         {
            _loc2_ = new RewardTrackPointIndicatorView(UnknownVarFromRewardTrackPrizeTrackView_IWindowController_1_5);
            _loc2_.window.visible = false;
            UnknownVarFromRewardTrackPrizeTrackView_IWindowController_1_1.addChild(_loc2_.window);
            UnknownVarFromRewardTrackPrizeTrackView_Vector_4.push(_loc2_);
         }
      }
      
      private function refreshPage(param1:Boolean) : void
      {
         refreshPrizeSlots(UnknownVarFromRewardTrackPrizeTrackView_Vector_1,_freePagePrizes[UnknownVarFromRewardTrackPrizeTrackView_Int_1]);
         refreshPrizeSlots(UnknownVarFromRewardTrackPrizeTrackView_Vector_2,_premiumPagePrizes[UnknownVarFromRewardTrackPrizeTrackView_Int_1]);
         refreshPointIndicatorSlots(_pagePointValues[UnknownVarFromRewardTrackPrizeTrackView_Int_1]);
         UnknownVarFromRewardTrackPrizeTrackView_RewardTrackMainProgressBarView_1.refreshByX(_layout.xForPoints(UnknownVarFromRewardTrackPrizeTrackView_RewardTrack_1.points,UnknownVarFromRewardTrackPrizeTrackView_Int_1),param1);
         refreshNavigation();
      }
      
      private function refreshPrizeSlots(param1:Vector.<RewardTrackPrizeView>, param2:Vector.<RewardTrackPrize>) : void
      {
         var _loc4_:int = 0;
         var _loc5_:RewardTrackPrizeView = null;
         var _loc6_:RewardTrackPrize = null;
         var _loc3_:Number = NaN;
         _loc4_ = 0;
         while(_loc4_ < param1.length)
         {
            _loc5_ = param1[_loc4_];
            if(_loc4_ >= param2.length)
            {
               _loc5_.clear();
            }
            else
            {
               _loc6_ = param2[_loc4_];
               _loc5_.initialize(UnknownVarFromRewardTrackPrizeTrackView_RewardTrackController_1,UnknownVarFromRewardTrackPrizeTrackView_RewardTrack_1,_loc6_);
               _loc3_ = _layout.xForPoints(_loc6_.requiredPoints,UnknownVarFromRewardTrackPrizeTrackView_Int_1);
               _loc5_.window.x = Math.round(_loc3_ - _loc5_.window.width / 2);
               _loc5_.window.visible = true;
            }
            _loc4_ += 1;
         }
      }
      
      private function refreshPointIndicatorSlots(param1:Vector.<int>) : void
      {
         var _loc4_:int = 0;
         var _loc2_:RewardTrackPointIndicatorView = null;
         var _loc3_:Number = NaN;
         _loc4_ = 0;
         while(_loc4_ < UnknownVarFromRewardTrackPrizeTrackView_Vector_4.length)
         {
            _loc2_ = UnknownVarFromRewardTrackPrizeTrackView_Vector_4[_loc4_];
            if(_loc4_ >= param1.length)
            {
               _loc2_.clear();
            }
            else
            {
               _loc2_.initialize(UnknownVarFromRewardTrackPrizeTrackView_RewardTrack_1,param1[_loc4_]);
               _loc3_ = _layout.xForPoints(param1[_loc4_],UnknownVarFromRewardTrackPrizeTrackView_Int_1);
               _loc2_.window.x = Math.round(_loc3_ - _loc2_.window.width / 2);
               _loc2_.window.visible = true;
            }
            _loc4_ += 1;
         }
      }
      
      private function maxPrizeCount(param1:Vector.<Vector.<RewardTrackPrize>>) : int
      {
         var _loc2_:int = 0;
         for each(var _loc3_ in param1)
         {
            _loc2_ = Math.max(_loc2_,_loc3_.length);
         }
         return _loc2_;
      }
      
      private function maxPointIndicatorCount() : int
      {
         var _loc1_:int = 0;
         for each(var _loc2_ in _pagePointValues)
         {
            _loc1_ = Math.max(_loc1_,_loc2_.length);
         }
         return _loc1_;
      }
      
      private function refreshPrizeStates() : void
      {
         for each(var _loc1_ in UnknownVarFromRewardTrackPrizeTrackView_Vector_3)
         {
            if(_loc1_.prize != null)
            {
               _loc1_.refreshState();
            }
         }
      }
      
      private function refreshPointIndicators() : void
      {
         for each(var _loc1_ in UnknownVarFromRewardTrackPrizeTrackView_Vector_4)
         {
            _loc1_.refreshAvailability();
         }
      }
      
      private function getPrizeView(param1:RewardTrackPrize) : RewardTrackPrizeView
      {
         for each(var _loc2_ in UnknownVarFromRewardTrackPrizeTrackView_Vector_3)
         {
            if(_loc2_.prize == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      private function refreshNavigation() : void
      {
         WindowUtils.disableSection(UnknownVarFromRewardTrackPrizeTrackView_IRegionWindow_1,UnknownVarFromRewardTrackPrizeTrackView_Int_1 <= 0);
         WindowUtils.disableSection(UnknownVarFromRewardTrackPrizeTrackView_IRegionWindow_2,UnknownVarFromRewardTrackPrizeTrackView_Int_1 >= _layout.pageCount - 1);
         refreshUnclaimedIndicators();
      }
      
      private function refreshUnclaimedIndicators() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         for each(var _loc3_ in UnknownVarFromRewardTrackPrizeTrackView_RewardTrack_1.prizes)
         {
            if(!(!_loc3_.isClaimable(UnknownVarFromRewardTrackPrizeTrackView_RewardTrack_1) || isPrizeVisibleOnPage(_loc3_,UnknownVarFromRewardTrackPrizeTrackView_Int_1)))
            {
               if(_layout.pageForPoints(_loc3_.requiredPoints) < UnknownVarFromRewardTrackPrizeTrackView_Int_1)
               {
                  _loc1_ += 1;
               }
               else
               {
                  _loc2_ += 1;
               }
            }
         }
         setUnclaimedIndicator(UnknownVarFromRewardTrackPrizeTrackView_IWindowController_1_6,previousUnclaimedCountText,_loc1_);
         setUnclaimedIndicator(UnknownVarFromRewardTrackPrizeTrackView_IWindowController_1_7,nextUnclaimedCountText,_loc2_);
      }
      
      private function isPrizeVisibleOnPage(param1:RewardTrackPrize, param2:int) : Boolean
      {
         var _loc3_:Vector.<RewardTrackPrize> = param1.premium ? _premiumPagePrizes[param2] : _freePagePrizes[param2];
         return _loc3_.indexOf(param1) >= 0;
      }
      
      private function setUnclaimedIndicator(param1:IWindowController_1, param2:ITextWindow, param3:int) : void
      {
         param1.visible = param3 > 0;
         if(param3 > 0)
         {
            param2.text = String(param3);
         }
      }
      
      private function onPreviousClicked(param1:WindowMouseEvent) : void
      {
         if(UnknownVarFromRewardTrackPrizeTrackView_Int_1 <= 0)
         {
            return;
         }
         UnknownVarFromRewardTrackPrizeTrackView_Int_1 -= 1;
         refreshPage(false);
      }
      
      private function onNextClicked(param1:WindowMouseEvent) : void
      {
         if(UnknownVarFromRewardTrackPrizeTrackView_Int_1 >= _layout.pageCount - 1)
         {
            return;
         }
         UnknownVarFromRewardTrackPrizeTrackView_Int_1 += 1;
         refreshPage(false);
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         UnknownVarFromRewardTrackPrizeTrackView_IRegionWindow_1.removeEventListener("WME_CLICK",onPreviousClicked);
         UnknownVarFromRewardTrackPrizeTrackView_IRegionWindow_2.removeEventListener("WME_CLICK",onNextClicked);
         for each(var _loc2_ in UnknownVarFromRewardTrackPrizeTrackView_Vector_3)
         {
            _loc2_.dispose();
         }
         for each(var _loc1_ in UnknownVarFromRewardTrackPrizeTrackView_Vector_4)
         {
            _loc1_.dispose();
         }
         UnknownVarFromRewardTrackPrizeTrackView_RewardTrackMainProgressBarView_1.dispose();
         UnknownVarFromRewardTrackPrizeTrackView_Vector_1 = null;
         UnknownVarFromRewardTrackPrizeTrackView_Vector_2 = null;
         UnknownVarFromRewardTrackPrizeTrackView_Vector_3 = null;
         UnknownVarFromRewardTrackPrizeTrackView_Vector_4 = null;
         _freePagePrizes = null;
         _premiumPagePrizes = null;
         _pagePointValues = null;
         UnknownVarFromRewardTrackPrizeTrackView_RewardTrackMainProgressBarView_1 = null;
         _layout = null;
         UnknownVarFromRewardTrackPrizeTrackView_RewardTrackController_1 = null;
         UnknownVarFromRewardTrackPrizeTrackView_RewardTrack_1 = null;
         _content = null;
         UnknownVarFromRewardTrackPrizeTrackView_IWindowController_1_1 = null;
         UnknownVarFromRewardTrackPrizeTrackView_IWindowController_1_2 = null;
         UnknownVarFromRewardTrackPrizeTrackView_IWindowController_1_3 = null;
         UnknownVarFromRewardTrackPrizeTrackView_IWindowController_1_4 = null;
         UnknownVarFromRewardTrackPrizeTrackView_IWindowController_1_5 = null;
         UnknownVarFromRewardTrackPrizeTrackView_IRegionWindow_1 = null;
         UnknownVarFromRewardTrackPrizeTrackView_IRegionWindow_2 = null;
         UnknownVarFromRewardTrackPrizeTrackView_IWindowController_1_6 = null;
         UnknownVarFromRewardTrackPrizeTrackView_IWindowController_1_7 = null;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      private function get previousUnclaimedCountText() : ITextWindow
      {
         return UnknownVarFromRewardTrackPrizeTrackView_IWindowController_1_6.findChildByName("previous_unclaimed_count") as ITextWindow;
      }
      
      private function get nextUnclaimedCountText() : ITextWindow
      {
         return UnknownVarFromRewardTrackPrizeTrackView_IWindowController_1_7.findChildByName("next_unclaimed_count") as ITextWindow;
      }
   }
}

