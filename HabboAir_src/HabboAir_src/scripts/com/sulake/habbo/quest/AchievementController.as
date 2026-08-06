package com.sulake.habbo.quest
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.runtime.IProfiler_1;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IFrameController;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.IWidgetWindowController;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.communication.messages.incoming.inventory.achievements.AchievementData;
   import com.sulake.habbo.communication.messages.outgoing.inventory.achievements.GetAchievementsComposer;
   import com.sulake.habbo.communication.messages.outgoing.tracking.EventLogMessageComposer;
   import com.sulake.habbo.session.events.BadgeImageReadyEvent;
   import com.sulake.habbo.window.widgets.IBadgeImageWidget;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   
   public class AchievementController implements IComponentInterfaceQueue, IProfiler_1
   {
      private static const CATEGORIES_COLUMN_COUNT:int = 3;
      
      private static const CATEGORY_SPACING_X:int = 8;
      
      private static const CATEGORY_SPACING_Y:int = 5;
      
      private static const CATEGORY_SPACING_TOP:int = 6;
      
      private static const CATEGORY_ROWS_MAX:int = 3;
      
      private static const ACHIEVEMENT_ROWS_MIN:int = 2;
      
      private static const ACHIEVEMENT_ROWS_MAX:int = 4;
      
      private static const ACHIEVEMENT_COLUMNS:int = 6;
      
      private static const IN_LEVEL_PROGRESS_BAR_WIDTH:int = 180;
      
      private static const TOTAL_PROGRESS_BAR_WIDTH:int = 246;
      
      private static const UnknownConstFromAchievementController_Uint_1:uint = 12910463;
      
      private static const UnknownConstFromAchievementController_Int_1:int = 45;
      
      private static const UnknownConstFromAchievementController_Int_2:int = 20;
      
      private static const ACHIEVEMENT_TOP_SPACING:int = 3;
      
      private static const IN_LEVEL_PROGRESS_BAR_LOC:Point = new Point(115,93);
      
      private static const TOTAL_PROGRESS_BAR_LOC:Point = new Point(72,1);
      
      private var _questEngine:HabboQuestEngine;
      
      private var _window:IFrameController;
      
      private var UnknownVarFromAchievementController_IWindowController_1_1:IWindowController_1;
      
      private var UnknownVarFromAchievementController_IWindowController_1_2:IWindowController_1;
      
      private var UnknownVarFromAchievementController_IWindowController_1_3:IWindowController_1;
      
      private var UnknownVarFromAchievementController_IWindowController_1_4:IWindowController_1;
      
      private var UnknownVarFromAchievementController_IWindowController_1_5:IWindowController_1;
      
      private var _categories:AchievementCategories;
      
      private var UnknownVarFromAchievementController_AchievementCategory_1:AchievementCategory;
      
      private var UnknownVarFromAchievementController_AchievementData_1:AchievementData;
      
      private var UnknownVarFromAchievementController_Timer_1:Timer;
      
      private var _badgeImages:Dictionary = new Dictionary();
      
      private var UnknownVarFromAchievementController_ProgressBar_1:ProgressBar;
      
      private var UnknownVarFromAchievementController_ProgressBar_2:ProgressBar;
      
      private var _pendingCategorySelect:String = null;
      
      private var UnknownVarFromAchievementController_AchievementData_2:AchievementData;
      
      private var UnknownVarFromAchievementController_Timer_2:Timer;
      
      private var _badgeYPositionFixes:Dictionary = new Dictionary();
      
      private var UnknownVarFromAchievementController_Boolean_1:Boolean;
      
      private var UnknownVarFromAchievementController_Dictionary_1:Dictionary = new Dictionary();
      
      public function AchievementController(param1:HabboQuestEngine)
      {
         super();
         _questEngine = param1;
         UnknownVarFromAchievementController_Timer_1 = new Timer(100,1);
         UnknownVarFromAchievementController_Timer_1.addEventListener("timer",doBadgeRefresh);
         UnknownVarFromAchievementController_Timer_2 = new Timer(2000,1);
         UnknownVarFromAchievementController_Timer_2.addEventListener("timer",switchIntoPendingLevel);
         _badgeYPositionFixes[16] = 1;
         _badgeYPositionFixes[28] = 6;
         _badgeYPositionFixes[38] = 4;
         _badgeYPositionFixes[39] = 3;
         _badgeYPositionFixes[40] = 1;
      }
      
      public static function moveAllChildrenToColumn(param1:IWindowController_1, param2:int, param3:int) : void
      {
         var _loc4_:int = 0;
         var _loc5_:IWindowModel = null;
         while(_loc4_ < param1.numChildren)
         {
            _loc5_ = param1.getChildAt(_loc4_);
            if(_loc5_ != null && _loc5_.visible && _loc5_.height > 0)
            {
               _loc5_.y = param2;
               param2 += _loc5_.height + param3;
            }
            _loc4_++;
         }
      }
      
      public static function getLowestPoint(param1:IWindowController_1) : int
      {
         var _loc2_:int = 0;
         var _loc4_:IWindowModel = null;
         var _loc3_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < param1.numChildren)
         {
            _loc4_ = param1.getChildAt(_loc2_);
            if(_loc4_.visible)
            {
               _loc3_ = Math.max(_loc3_,_loc4_.y + _loc4_.height);
            }
            _loc2_++;
         }
         return _loc3_;
      }
      
      public function dispose() : void
      {
         _questEngine = null;
         _badgeImages = null;
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
         if(UnknownVarFromAchievementController_Timer_1)
         {
            UnknownVarFromAchievementController_Timer_1.removeEventListener("timer",doBadgeRefresh);
            UnknownVarFromAchievementController_Timer_1.reset();
            UnknownVarFromAchievementController_Timer_1 = null;
         }
         if(UnknownVarFromAchievementController_Timer_2)
         {
            UnknownVarFromAchievementController_Timer_2.removeEventListener("timer",switchIntoPendingLevel);
            UnknownVarFromAchievementController_Timer_2.reset();
            UnknownVarFromAchievementController_Timer_2 = null;
         }
         if(UnknownVarFromAchievementController_ProgressBar_1)
         {
            UnknownVarFromAchievementController_ProgressBar_1.dispose();
            UnknownVarFromAchievementController_ProgressBar_1 = null;
         }
         if(UnknownVarFromAchievementController_ProgressBar_2)
         {
            UnknownVarFromAchievementController_ProgressBar_2.dispose();
            UnknownVarFromAchievementController_ProgressBar_2 = null;
         }
         UnknownVarFromAchievementController_IWindowController_1_1 = null;
         UnknownVarFromAchievementController_IWindowController_1_3 = null;
         UnknownVarFromAchievementController_IWindowController_1_3 = null;
         UnknownVarFromAchievementController_IWindowController_1_4 = null;
         UnknownVarFromAchievementController_IWindowController_1_5 = null;
      }
      
      public function get disposed() : Boolean
      {
         return _questEngine == null;
      }
      
      public function isVisible() : Boolean
      {
         return _window && _window.visible;
      }
      
      public function close() : void
      {
         UnknownVarFromAchievementController_Dictionary_1 = new Dictionary();
         broadcastUnseenAchievementsCount();
         if(_window)
         {
            _window.visible = false;
         }
      }
      
      private function broadcastUnseenAchievementsCount() : void
      {
         var _loc2_:int = 0;
         for each(var _loc1_ in UnknownVarFromAchievementController_Dictionary_1)
         {
            if(!isSkippedForUnseenBroadcast(_loc1_.badgeId))
            {
               _loc2_++;
            }
         }
      }
      
      public function onRoomExit() : void
      {
         this.close();
      }
      
      public function onToolbarClick() : void
      {
         if(isVisible())
         {
            close();
         }
         else
         {
            show();
         }
      }
      
      public function ensureAchievementsInitialized() : void
      {
         if(_categories == null)
         {
            _questEngine.send(new GetAchievementsComposer());
         }
      }
      
      public function show() : void
      {
         if(_categories == null)
         {
            _questEngine.send(new GetAchievementsComposer());
            UnknownVarFromAchievementController_Boolean_1 = true;
         }
         else
         {
            refresh();
            this._window.visible = true;
            this._window.activate();
         }
      }
      
      public function onAchievements(param1:Array, param2:String) : void
      {
         if(_categories == null)
         {
            _categories = new AchievementCategories(param1,_questEngine);
         }
         if(!UnknownVarFromAchievementController_Boolean_1)
         {
            return;
         }
         UnknownVarFromAchievementController_Boolean_1 = false;
         refresh();
         this._window.visible = true;
         this._window.activate();
         var _loc3_:String = _pendingCategorySelect == null ? param2 : _pendingCategorySelect;
         var _loc4_:AchievementCategory = _categories.getCategoryByCode(_loc3_);
         if(_loc4_ != null)
         {
            pickCategory(_loc4_);
            _pendingCategorySelect = null;
         }
      }
      
      public function onAchievement(param1:AchievementData) : void
      {
         var _loc2_:Boolean = false;
         if(_categories != null)
         {
            _loc2_ = UnknownVarFromAchievementController_AchievementData_1 && UnknownVarFromAchievementController_AchievementData_1.achievementId == param1.achievementId;
            if(!_loc2_ && !(param1.achievementId in UnknownVarFromAchievementController_Dictionary_1))
            {
               UnknownVarFromAchievementController_Dictionary_1[param1.achievementId] = param1;
               broadcastUnseenAchievementsCount();
            }
            if(_loc2_ && param1.level > UnknownVarFromAchievementController_AchievementData_1.level)
            {
               UnknownVarFromAchievementController_AchievementData_1.setMaxProgress();
               UnknownVarFromAchievementController_AchievementData_2 = param1;
               UnknownVarFromAchievementController_Timer_2.start();
            }
            else
            {
               _categories.update(param1);
               if(_loc2_)
               {
                  UnknownVarFromAchievementController_AchievementData_1 = param1;
               }
            }
            if(_window && _window.visible)
            {
               refresh();
            }
         }
      }
      
      private function getCategoryUnseenCount(param1:String) : int
      {
         var _loc3_:int = 0;
         for each(var _loc2_ in UnknownVarFromAchievementController_Dictionary_1)
         {
            if(_loc2_.category == param1)
            {
               _loc3_++;
            }
         }
         return _loc3_;
      }
      
      private function refresh() : void
      {
         prepareWindow();
         refreshCategoryList();
         refreshCategoryListFooter();
         refreshAchievementsHeader();
         refreshAchievementList();
         refreshAchievementDetails();
         moveAllChildrenToColumn(_window.content,0,4);
         _window.height = getLowestPoint(_window.content) + 45;
      }
      
      private function refreshCategoryList() : void
      {
         var _loc3_:int = 0;
         var _loc4_:AchievementCategory = null;
         var _loc1_:Boolean = false;
         if(UnknownVarFromAchievementController_AchievementCategory_1 != null)
         {
            UnknownVarFromAchievementController_IWindowController_1_1.visible = false;
            return;
         }
         UnknownVarFromAchievementController_IWindowController_1_1.visible = true;
         var _loc2_:Vector.<AchievementCategory> = _categories.categoryList;
         _loc3_ = 0;
         while(true)
         {
            if(_loc3_ < _loc2_.length)
            {
               _loc4_ = _loc2_[_loc3_];
               if(_loc4_.visibleInList())
               {
                  refreshCategoryEntry(_loc3_,_loc4_);
               }
            }
            else
            {
               _loc1_ = refreshCategoryEntry(_loc3_,null);
               if(_loc1_)
               {
                  break;
               }
            }
            _loc3_++;
         }
         UnknownVarFromAchievementController_IWindowController_1_1.height = getLowestPoint(UnknownVarFromAchievementController_IWindowController_1_1);
      }
      
      private function refreshCategoryListFooter() : void
      {
         if(UnknownVarFromAchievementController_AchievementCategory_1 != null)
         {
            UnknownVarFromAchievementController_IWindowController_1_5.visible = false;
            return;
         }
         UnknownVarFromAchievementController_IWindowController_1_5.visible = true;
         UnknownVarFromAchievementController_ProgressBar_2.refresh(_categories.getProgress(),_categories.getMaxProgress(),0,0);
      }
      
      private function achievementIsVisible(param1:AchievementData) : Boolean
      {
         if(UnknownVarFromAchievementController_AchievementCategory_1 == null || UnknownVarFromAchievementController_AchievementCategory_1.code != "wired_games")
         {
            return true;
         }
         var _loc4_:String = param1.code;
         if(_loc4_.indexOf("WF_") != 0)
         {
            return false;
         }
         _loc4_ = _loc4_.substr(3);
         var _loc3_:Vector.<String> = _questEngine.wired.achievementsInRoom;
         for each(var _loc2_ in _loc3_)
         {
            if(_loc2_ == _loc4_)
            {
               return true;
            }
         }
         return false;
      }
      
      private function refreshAchievementList() : void
      {
         var _loc7_:int = 0;
         var _loc5_:AchievementData = null;
         var _loc3_:Boolean = false;
         var _loc2_:IWindowModel = _window.findChildByName("achievements_list");
         if(UnknownVarFromAchievementController_AchievementCategory_1 == null)
         {
            _loc2_.visible = false;
            return;
         }
         _loc2_.visible = true;
         Logger.log(UnknownVarFromAchievementController_AchievementCategory_1.code + " has " + UnknownVarFromAchievementController_AchievementCategory_1.achievements.length + " achievements");
         var _loc6_:Vector.<AchievementData> = UnknownVarFromAchievementController_AchievementCategory_1.achievements;
         while(UnknownVarFromAchievementController_IWindowController_1_2.numChildren > 0)
         {
            UnknownVarFromAchievementController_IWindowController_1_2.removeChildAt(0);
         }
         var _loc4_:int = 0;
         _loc7_ = 0;
         while(true)
         {
            if(_loc7_ < _loc6_.length)
            {
               _loc5_ = _loc6_[_loc7_];
               if(achievementIsVisible(_loc5_))
               {
                  refreshAchievementEntry(_loc4_,_loc5_);
                  _loc4_ += 1;
               }
            }
            else
            {
               _loc3_ = refreshAchievementEntry(_loc4_,null);
               _loc4_ += 1;
               if(_loc3_)
               {
                  break;
               }
            }
            _loc7_++;
         }
         UnknownVarFromAchievementController_IWindowController_1_2.height = getLowestPoint(UnknownVarFromAchievementController_IWindowController_1_2);
         _loc2_.height = UnknownVarFromAchievementController_IWindowController_1_2.height + 1;
         _window.findChildByName("achievements_scrollarea").height = _loc2_.height;
         var _loc1_:IWindowModel = _window.findChildByName("achievements_scrollbar");
         _loc1_.visible = achievementsNeedScrolling;
         _loc1_.height = _loc2_.height;
      }
      
      private function refreshAchievementsHeader() : void
      {
         if(UnknownVarFromAchievementController_AchievementCategory_1 == null)
         {
            UnknownVarFromAchievementController_IWindowController_1_4.visible = false;
            return;
         }
         UnknownVarFromAchievementController_IWindowController_1_4.visible = true;
         UnknownVarFromAchievementController_IWindowController_1_4.findChildByName("category_name_txt").caption = _questEngine.getAchievementCategoryName(UnknownVarFromAchievementController_AchievementCategory_1.code);
         _questEngine.localization.registerParameter("achievements.details.categoryprogress","progress",UnknownVarFromAchievementController_AchievementCategory_1.getProgress().toString());
         _questEngine.localization.registerParameter("achievements.details.categoryprogress","limit",UnknownVarFromAchievementController_AchievementCategory_1.getMaxProgress().toString());
         _questEngine.setupAchievementCategoryImage(UnknownVarFromAchievementController_IWindowController_1_4,UnknownVarFromAchievementController_AchievementCategory_1,false);
      }
      
      private function refreshAchievementDetails() : void
      {
         if(UnknownVarFromAchievementController_AchievementData_1 == null)
         {
            UnknownVarFromAchievementController_IWindowController_1_3.visible = false;
            return;
         }
         UnknownVarFromAchievementController_IWindowController_1_3.visible = true;
         var _loc2_:String = getAchievedBadgeId(UnknownVarFromAchievementController_AchievementData_1);
         UnknownVarFromAchievementController_IWindowController_1_3.findChildByName("achievement_name_txt").caption = _questEngine.localization.getBadgeName(_loc2_);
         var _loc1_:String = _questEngine.localization.getBadgeDesc(_loc2_);
         UnknownVarFromAchievementController_IWindowController_1_3.findChildByName("achievement_desc_txt").caption = _loc1_ == null ? "" : _loc1_;
         _questEngine.localization.registerParameter("achievements.details.level","level",UnknownVarFromAchievementController_AchievementData_1.finalLevel ? UnknownVarFromAchievementController_AchievementData_1.level.toString() : (UnknownVarFromAchievementController_AchievementData_1.level - 1).toString());
         _questEngine.localization.registerParameter("achievements.details.level","limit",UnknownVarFromAchievementController_AchievementData_1.levelCount.toString());
         _questEngine.refreshReward(!UnknownVarFromAchievementController_AchievementData_1.finalLevel,UnknownVarFromAchievementController_IWindowController_1_3,UnknownVarFromAchievementController_AchievementData_1.levelRewardPointType,UnknownVarFromAchievementController_AchievementData_1.levelRewardPoints);
         refreshBadgeImageLarge(UnknownVarFromAchievementController_IWindowController_1_3,UnknownVarFromAchievementController_AchievementData_1);
         UnknownVarFromAchievementController_ProgressBar_1.refresh(UnknownVarFromAchievementController_AchievementData_1.currentPoints,UnknownVarFromAchievementController_AchievementData_1.scoreLimit,UnknownVarFromAchievementController_AchievementData_1.achievementId * 10000 + UnknownVarFromAchievementController_AchievementData_1.level,UnknownVarFromAchievementController_AchievementData_1.scoreAtStartOfLevel);
         UnknownVarFromAchievementController_ProgressBar_1.visible = UnknownVarFromAchievementController_AchievementData_1.displayMethod != 1 && !UnknownVarFromAchievementController_AchievementData_1.finalLevel;
      }
      
      private function prepareWindow() : void
      {
         if(this._window != null)
         {
            return;
         }
         _window = IFrameController(_questEngine.getXmlWindow("Achievements"));
         _window.findChildByTag("close").procedure = onWindowClose;
         _window.findChildByName("back_button").procedure = onBack;
         _window.center();
         _window.y = 20;
         UnknownVarFromAchievementController_IWindowController_1_1 = IWindowController_1(_window.findChildByName("categories_cont"));
         UnknownVarFromAchievementController_IWindowController_1_4 = IWindowController_1(_window.findChildByName("achievements_header_cont"));
         UnknownVarFromAchievementController_IWindowController_1_2 = IWindowController_1(_window.findChildByName("achievements_cont"));
         UnknownVarFromAchievementController_IWindowController_1_3 = IWindowController_1(_window.findChildByName("achievement_cont"));
         UnknownVarFromAchievementController_IWindowController_1_5 = IWindowController_1(_window.findChildByName("categories_footer_cont"));
         UnknownVarFromAchievementController_ProgressBar_1 = new ProgressBar(_questEngine,UnknownVarFromAchievementController_IWindowController_1_3,180,"achievements.details.progress",true,IN_LEVEL_PROGRESS_BAR_LOC);
         UnknownVarFromAchievementController_ProgressBar_2 = new ProgressBar(_questEngine,UnknownVarFromAchievementController_IWindowController_1_5,246,"achievements.categories.totalprogress",true,TOTAL_PROGRESS_BAR_LOC);
      }
      
      private function refreshCategoryEntry(param1:int, param2:AchievementCategory) : Boolean
      {
         var _loc5_:int = 0;
         var _loc3_:IWindowController_1 = IWindowController_1(UnknownVarFromAchievementController_IWindowController_1_1.getChildByName(param1.toString()));
         var _loc4_:int = Math.floor(param1 / 3);
         var _loc6_:* = _loc4_ < 3;
         if(_loc3_ == null)
         {
            if(param2 == null && !_loc6_)
            {
               return true;
            }
            _loc3_ = IWindowController_1(_questEngine.getXmlWindow("AchievementCategory"));
            _loc3_.name = param1.toString();
            UnknownVarFromAchievementController_IWindowController_1_1.addChild(_loc3_);
            _loc3_.findChildByName("category_region").procedure = onSelectCategory;
            _loc3_.x = (_loc3_.width + 8) * (param1 % 3);
            _loc3_.y = (_loc3_.height + 5) * Math.floor(param1 / 3) + 6;
         }
         _loc3_.findChildByName("category_region").id = param1;
         _loc3_.findChildByName("category_region").visible = param2 != null;
         _loc3_.findChildByName("category_bg_inact").visible = param2 == null;
         _loc3_.findChildByName("category_bg_act").visible = param2 != null;
         _loc3_.findChildByName("category_bg_act_hover").visible = false;
         _loc3_.findChildByName("header_txt").visible = param2 != null;
         _loc3_.findChildByName("completion_txt").visible = param2 != null;
         _loc3_.findChildByName("category_pic_bitmap").visible = param2 != null;
         _loc3_.findChildByName("unseen_count_border").visible = false;
         if(param2)
         {
            _loc3_.findChildByName("header_txt").caption = _questEngine.getAchievementCategoryName(param2.code);
            _loc3_.findChildByName("completion_txt").caption = param2.getProgress() + "/" + param2.getMaxProgress();
            _questEngine.setupAchievementCategoryImage(_loc3_,param2,true);
            _loc5_ = getCategoryUnseenCount(param2.code);
            if(_loc5_ > 0)
            {
               _loc3_.findChildByName("unseen_count_border").visible = true;
               _loc3_.findChildByName("unseen_count").caption = _loc5_.toString();
            }
            _loc3_.visible = true;
         }
         else
         {
            _loc3_.visible = _loc6_;
         }
         return false;
      }
      
      private function refreshAchievementEntry(param1:int, param2:AchievementData) : Boolean
      {
         var _loc5_:int = param1 / achievementsColumnCount;
         var _loc8_:* = _loc5_ < 2;
         if(param2 == null && !_loc8_)
         {
            return true;
         }
         var _loc3_:IWindowController_1 = _questEngine.getXmlWindow("Achievement") as IWindowController_1;
         UnknownVarFromAchievementController_IWindowController_1_2.addChild(_loc3_);
         _loc3_.x = (_loc3_.width + (achievementsNeedScrolling ? 5 : 0)) * (param1 % achievementsColumnCount);
         Logger.log("Refreshing " + param1 + " where count is " + UnknownVarFromAchievementController_AchievementCategory_1.achievements.length + ", row=" + _loc5_ + ", column=" + param1 % achievementsColumnCount);
         _loc3_.y = _loc3_.height * _loc5_ + 3;
         _loc3_.findChildByName("bg_region").procedure = onSelectAchievement;
         var _loc6_:IWindowModel = _loc3_.findChildByName("bg_region");
         _loc6_.id = param1;
         _loc6_.visible = param2 != null;
         var _loc4_:IWindowModel = _loc3_.findChildByName("bg_unselected_bitmap");
         var _loc7_:IWindowModel = _loc3_.findChildByName("bg_selected_bitmap");
         this.refreshBadgeImage(_loc3_,param2);
         _loc4_.color = param2 != null && param2.achievementId in UnknownVarFromAchievementController_Dictionary_1 ? 12910463 : 16777215;
         if(param2)
         {
            _loc4_.visible = param2 != UnknownVarFromAchievementController_AchievementData_1;
            _loc7_.visible = param2 == UnknownVarFromAchievementController_AchievementData_1;
            _loc3_.visible = true;
         }
         else if(_loc8_)
         {
            _loc7_.visible = false;
            _loc4_.visible = true;
            _loc3_.visible = true;
         }
         else
         {
            _loc3_.visible = false;
         }
         return false;
      }
      
      private function onWindowClose(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type == "WME_CLICK")
         {
            close();
         }
      }
      
      private function onSelectCategory(param1:WindowEvent, param2:IWindowModel) : void
      {
         var _loc3_:int = param2.id;
         Logger.log("Category index: " + _loc3_);
         if(param1.type == "WME_CLICK")
         {
            pickCategory(_categories.categoryList[_loc3_]);
         }
         else if(param1.type == "WME_OUT")
         {
            refreshMouseOver(-999);
         }
         else if(param1.type == "WME_OVER")
         {
            refreshMouseOver(_loc3_);
         }
      }
      
      private function pickCategory(param1:AchievementCategory) : void
      {
         UnknownVarFromAchievementController_AchievementCategory_1 = param1;
         UnknownVarFromAchievementController_AchievementData_1 = UnknownVarFromAchievementController_AchievementCategory_1.achievements[0];
         Logger.log("Category: " + UnknownVarFromAchievementController_AchievementCategory_1.code);
         this.refresh();
         _questEngine.send(new EventLogMessageComposer("Achievements",UnknownVarFromAchievementController_AchievementCategory_1.code,"Category selected"));
      }
      
      public function selectCategoryInternalLink(param1:String) : void
      {
         var _loc2_:AchievementCategory = _categories != null ? _categories.getCategoryByCode(param1) : null;
         if(_loc2_ != null)
         {
            pickCategory(_loc2_);
         }
         else
         {
            _pendingCategorySelect = param1;
         }
      }
      
      private function refreshMouseOver(param1:int) : void
      {
         var _loc4_:int = 0;
         var _loc2_:* = false;
         var _loc3_:IWindowController_1 = null;
         var _loc5_:IWindowModel = null;
         _loc4_ = 0;
         while(_loc4_ < UnknownVarFromAchievementController_IWindowController_1_1.numChildren)
         {
            _loc2_ = _loc4_ == param1;
            _loc3_ = IWindowController_1(UnknownVarFromAchievementController_IWindowController_1_1.getChildAt(_loc4_));
            _loc3_.findChildByName("category_bg_act").visible = !_loc2_ && _loc4_ < _categories.categoryList.length;
            _loc3_.findChildByName("category_bg_act_hover").visible = _loc2_;
            _loc5_ = _loc3_.findChildByName("hover_container");
            _loc5_.x = _loc2_ ? 0 : 1;
            _loc5_.y = _loc2_ ? 0 : 1;
            _loc4_++;
         }
      }
      
      private function onSelectAchievement(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         var _loc3_:int = param2.id;
         UnknownVarFromAchievementController_AchievementData_1 = UnknownVarFromAchievementController_AchievementCategory_1.achievements[_loc3_];
         this.refresh();
         _questEngine.send(new EventLogMessageComposer("Achievements",UnknownVarFromAchievementController_AchievementData_1.achievementId.toString(),"Achievement selected"));
      }
      
      private function onBack(param1:WindowEvent, param2:IWindowModel) : void
      {
         var _loc4_:Array = null;
         var _loc3_:* = null;
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         if(UnknownVarFromAchievementController_AchievementCategory_1 != null)
         {
            _loc4_ = [];
            for each(_loc3_ in UnknownVarFromAchievementController_Dictionary_1)
            {
               if(_loc3_.category != UnknownVarFromAchievementController_AchievementCategory_1.code)
               {
                  _loc4_.push(_loc3_);
               }
            }
            UnknownVarFromAchievementController_Dictionary_1 = new Dictionary();
            for each(_loc3_ in _loc4_)
            {
               UnknownVarFromAchievementController_Dictionary_1[_loc3_.achievementId] = _loc3_;
            }
            broadcastUnseenAchievementsCount();
         }
         UnknownVarFromAchievementController_AchievementCategory_1 = null;
         UnknownVarFromAchievementController_AchievementData_1 = null;
         this.refresh();
      }
      
      private function refreshBadgeImage(param1:IWindowController_1, param2:AchievementData) : void
      {
         var _loc4_:IWidgetWindowController = param1.findChildByName("achievement_pic_bitmap") as IWidgetWindowController;
         var _loc3_:IBadgeImageWidget = _loc4_.widget as IBadgeImageWidget;
         if(param2 == null)
         {
            _loc4_.visible = false;
            return;
         }
         IStaticBitmapWrapperWindow(IWindowController_1(_loc4_.rootWindow).findChildByName("bitmap")).assetUri = "common_loading_icon";
         _loc3_.badgeId = getAchievedBadgeId(param2);
         _loc3_.greyscale = !param2.firstLevelAchieved;
         _loc4_.visible = true;
      }
      
      private function refreshBadgeImageLarge(param1:IWindowController_1, param2:AchievementData) : void
      {
         var _loc4_:IWidgetWindowController = param1.findChildByName("achievement_pic_bitmap") as IWidgetWindowController;
         var _loc3_:IBadgeImageWidget = _loc4_.widget as IBadgeImageWidget;
         IStaticBitmapWrapperWindow(IWindowController_1(_loc4_.rootWindow).findChildByName("bitmap")).assetUri = "common_loading_icon";
         _loc3_.badgeId = getAchievedBadgeId(param2);
         _loc3_.greyscale = !param2.firstLevelAchieved;
         _loc4_.visible = true;
      }
      
      private function doBadgeRefresh(param1:TimerEvent) : void
      {
         this.UnknownVarFromAchievementController_Timer_1.reset();
         this.refresh();
      }
      
      private function switchIntoPendingLevel(param1:TimerEvent) : void
      {
         UnknownVarFromAchievementController_AchievementData_1 = UnknownVarFromAchievementController_AchievementData_2;
         _categories.update(UnknownVarFromAchievementController_AchievementData_2);
         UnknownVarFromAchievementController_AchievementData_2 = null;
         this.refresh();
      }
      
      public function onBadgeImageReady(param1:BadgeImageReadyEvent) : void
      {
         if(_window == null)
         {
            return;
         }
         this._badgeImages[param1.badgeId] = param1.badgeImage;
         if(!this.UnknownVarFromAchievementController_Timer_1.running)
         {
            this.UnknownVarFromAchievementController_Timer_1.start();
         }
      }
      
      public function update(param1:uint) : void
      {
         if(UnknownVarFromAchievementController_ProgressBar_1 != null)
         {
            UnknownVarFromAchievementController_ProgressBar_1.updateView(param1);
         }
         if(UnknownVarFromAchievementController_ProgressBar_2 != null)
         {
            UnknownVarFromAchievementController_ProgressBar_2.updateView(param1);
         }
      }
      
      private function getAchievedBadgeId(param1:AchievementData) : String
      {
         if(param1.levelCount == 1)
         {
            return param1.badgeId;
         }
         return param1.finalLevel ? param1.badgeId : _questEngine.localization.getPreviousLevelBadgeId(param1.badgeId);
      }
      
      private function getPositionFix(param1:int) : int
      {
         return !!_badgeYPositionFixes[param1] ? _badgeYPositionFixes[param1] : 0;
      }
      
      private function get achievementsColumnCount() : int
      {
         if(achievementsNeedScrolling)
         {
            return 6 - 1;
         }
         return 6;
      }
      
      private function get achievementsNeedScrolling() : Boolean
      {
         return UnknownVarFromAchievementController_AchievementCategory_1 != null && UnknownVarFromAchievementController_AchievementCategory_1.achievements.length > 4 * 6;
      }
      
      private function isSkippedForUnseenBroadcast(param1:String) : Boolean
      {
         var _loc3_:Boolean = false;
         var _loc4_:Array = _questEngine.getProperty("toolbar.unseen_notification.skipped_badge_ids").split(",");
         for each(var _loc2_ in _loc4_)
         {
            if(param1.search(_loc2_) != -1)
            {
               _loc3_ = true;
               break;
            }
         }
         return _loc3_;
      }
      
      public function getAchievementLevel(param1:String, param2:String) : int
      {
         var _loc4_:AchievementCategory = null;
         if(_categories != null)
         {
            _loc4_ = _categories.getCategoryByCode(param1);
            if(_loc4_ != null)
            {
               for each(var _loc3_ in _loc4_.achievements)
               {
                  if(_loc3_.badgeId.indexOf(param2) == 0)
                  {
                     return _loc3_.finalLevel ? _loc3_.level : Math.max(0,_loc3_.level - 1);
                  }
               }
            }
         }
         return 0;
      }
   }
}

