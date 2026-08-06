package com.sulake.habbo.quest.seasonalcalendar
{
   import com.sulake.core.assets.AssetLoaderStruct;
   import com.sulake.core.assets.ISoundAsset;
   import com.sulake.core.assets.loaders.AssetLoaderEvent;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.runtime.IProfiler_1;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.components.IFrameController;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.UnknownICoreWindowComponents6;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.communication.messages.incoming.quest.QuestMessageData;
   import com.sulake.habbo.quest.HabboQuestEngine;
   import flash.display.BitmapData;
   import flash.events.TimerEvent;
   import flash.net.URLRequest;
   import flash.utils.Timer;
   
   public class Calendar implements IComponentInterfaceQueue, IProfiler_1
   {
      private static const BG_IMAGE_PREFIX:String = "background_";
      
      private static const ENTITY_IMAGE_PREFIX:String = "day";
      
      private static const ENTITY_IMAGE_UNCOMPLETE_POSTFIX:String = "_uncomplete";
      
      private static const ENTITY_IMAGE_COMPLETED_POSTFIX:String = "_completed";
      
      private static const SHOW_FUTURE_INACTIVE_ENTITIES_COUNT:int = 2;
      
      private static const UnknownConstFromCalendar_Int_1:int = 3;
      
      private static const ENTITY_SPACING:int = 80;
      
      private static const ENTITIES_LEFT_MARGIN:int = 37;
      
      private static const UnknownConstFromCalendar_Int_2:int = 7;
      
      private static const DAILY_REFRESH_DELAY_MINUTES:int = 5;
      
      private static const FLASH_PULSE_LENGHT_IN_MS:int = 2000;
      
      private static const FLASH_MAX_BRIGHTNESS:int = 100;
      
      private var _questEngine:HabboQuestEngine;
      
      private var UnknownVarFromCalendar_MainWindow_1:MainWindow;
      
      private var UnknownVarFromCalendar_Array_1:Array;
      
      private var _backgroundImageCache:Vector.<BitmapData>;
      
      private var _graphicEntityCache:Vector.<BitmapData>;
      
      private var UnknownVarFromCalendar_Map_1:Map;
      
      private var _bgAssetNameArray:Array;
      
      private var _imageGalleryHost:String;
      
      private var UnknownVarFromCalendar_CalendarBackgroundRenderer_1:CalendarBackgroundRenderer;
      
      private var _entityWindows:Vector.<IWindowController_1>;
      
      private var _states:Array;
      
      private var UnknownVarFromCalendar_CalendarArrowButton_1:CalendarArrowButton;
      
      private var UnknownVarFromCalendar_CalendarArrowButton_2:CalendarArrowButton;
      
      private var UnknownVarFromCalendar_IWindowController_1_1:IWindowController_1;
      
      private var UnknownVarFromCalendar_IWindowController_1_2:IWindowController_1;
      
      private var UnknownVarFromCalendar_IBitmapWrapperController_1:IBitmapWrapperController;
      
      private var UnknownVarFromCalendar_Int_1:int = -1;
      
      private var UnknownVarFromCalendar_Int_2:int = -1;
      
      private var _highestAvailableQuestIndex:int = -1;
      
      private var _maximumEntities:int = 42;
      
      private var UnknownVarFromCalendar_Timer_1:Timer;
      
      private var UnknownVarFromCalendar_Int_3:int = 0;
      
      private var UnknownVarFromCalendar_Int_4:int = 0;
      
      private var UnknownVarFromCalendar_Int_5:int = 0;
      
      private var UnknownVarFromCalendar_Int_6:int = -1;
      
      private var UnknownVarFromCalendar_Int_7:int;
      
      private var UnknownVarFromCalendar_Int_8:int = -1;
      
      private var UnknownVarFromCalendar_Boolean_1:Boolean = false;
      
      private var UnknownVarFromCalendar_Boolean_2:Boolean = false;
      
      private var UnknownVarFromCalendar_Timer_2:Timer;
      
      private var UnknownVarFromCalendar_Int_9:int = -1;
      
      public function Calendar(param1:HabboQuestEngine, param2:MainWindow)
      {
         super();
         _questEngine = param1;
         UnknownVarFromCalendar_MainWindow_1 = param2;
      }
      
      private static function adjustBrightness(param1:uint, param2:int) : uint
      {
         var _loc3_:int = Math.min(255,Math.max(0,(param1 >> 16 & 0xFF) + param2));
         var _loc5_:int = Math.min(255,Math.max(0,(param1 >> 8 & 0xFF) + param2));
         var _loc4_:int = Math.min(255,Math.max(0,(param1 & 0xFF) + param2));
         return ((_loc3_ & 0xFF) << 16) + ((_loc5_ & 0xFF) << 8) + (_loc4_ & 0xFF);
      }
      
      private function getImageGalleryHost() : String
      {
         return _imageGalleryHost;
      }
      
      public function dispose() : void
      {
         if(!disposed)
         {
            _questEngine.removeUpdateReceiver(this);
            cleanUpEntityWindows();
            if(UnknownVarFromCalendar_CalendarBackgroundRenderer_1 != null)
            {
               UnknownVarFromCalendar_CalendarBackgroundRenderer_1.dispose();
               UnknownVarFromCalendar_CalendarBackgroundRenderer_1 = null;
            }
            if(UnknownVarFromCalendar_CalendarArrowButton_1 != null)
            {
               UnknownVarFromCalendar_CalendarArrowButton_1.dispose();
               UnknownVarFromCalendar_CalendarArrowButton_1 = null;
            }
            if(UnknownVarFromCalendar_CalendarArrowButton_2 != null)
            {
               UnknownVarFromCalendar_CalendarArrowButton_2.dispose();
               UnknownVarFromCalendar_CalendarArrowButton_2 = null;
            }
            if(UnknownVarFromCalendar_Timer_1 != null)
            {
               UnknownVarFromCalendar_Timer_1.stop();
               UnknownVarFromCalendar_Timer_1 = null;
            }
            if(UnknownVarFromCalendar_Timer_2 != null)
            {
               UnknownVarFromCalendar_Timer_2.stop();
               UnknownVarFromCalendar_Timer_2 = null;
            }
            _backgroundImageCache = null;
            _graphicEntityCache = null;
            _states = null;
            UnknownVarFromCalendar_Map_1 = null;
            _bgAssetNameArray = null;
            _questEngine = null;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _questEngine == null;
      }
      
      public function onQuests(param1:Array) : void
      {
         var _loc4_:Date = new Date();
         UnknownVarFromCalendar_Int_9 = _loc4_.getDate();
         var _loc2_:int = UnknownVarFromCalendar_Int_2;
         UnknownVarFromCalendar_Array_1 = [];
         _highestAvailableQuestIndex = 0;
         var _loc3_:QuestMessageData = null;
         for each(_loc3_ in param1)
         {
            if(_questEngine.isSeasonalQuest(_loc3_))
            {
               UnknownVarFromCalendar_Array_1.push(_loc3_);
               if(_highestAvailableQuestIndex < _loc3_.sortOrder - 1)
               {
                  _highestAvailableQuestIndex = _loc3_.sortOrder - 1;
               }
            }
         }
         UnknownVarFromCalendar_Array_1.sortOn(["sortOrder"]);
         _maximumEntities = int(_questEngine.configuration.getProperty("seasonalQuestCalendar.maximum.entities"));
         UnknownVarFromCalendar_Int_2 = Math.min(_maximumEntities,_highestAvailableQuestIndex + 1 + 2);
         if(_loc2_ != -1 && UnknownVarFromCalendar_Int_2 > _loc2_)
         {
            prepareImages();
         }
      }
      
      public function prepare(param1:IFrameController) : void
      {
         var _loc2_:IBitmapWrapperController = null;
         _imageGalleryHost = UnknownVarFromCalendar_MainWindow_1.getCalendarImageGalleryHost();
         UnknownVarFromCalendar_IWindowController_1_1 = IWindowController_1(param1.findChildByName("calendar_cont"));
         UnknownVarFromCalendar_IBitmapWrapperController_1 = IBitmapWrapperController(param1.findChildByName("background_slice"));
         UnknownVarFromCalendar_IWindowController_1_2 = IWindowController_1(param1.findChildByName("entity_template"));
         UnknownVarFromCalendar_IWindowController_1_2.visible = false;
         UnknownVarFromCalendar_CalendarBackgroundRenderer_1 = new CalendarBackgroundRenderer();
         UnknownVarFromCalendar_CalendarArrowButton_1 = new CalendarArrowButton(_questEngine.assets,IBitmapWrapperController(param1.findChildByName("button_left")),0,scrollArrowProcedure);
         UnknownVarFromCalendar_CalendarArrowButton_2 = new CalendarArrowButton(_questEngine.assets,IBitmapWrapperController(param1.findChildByName("button_right")),1,scrollArrowProcedure);
         _loc2_ = IBitmapWrapperController(param1.findChildByName("stripe_mask_left"));
         _loc2_.bitmap = BitmapData(ISoundAsset(_questEngine.assets.getAssetByName("stripe_mask_L")).content);
         _loc2_ = IBitmapWrapperController(param1.findChildByName("stripe_mask_right"));
         _loc2_.bitmap = BitmapData(ISoundAsset(_questEngine.assets.getAssetByName("stripe_mask_R")).content);
         if(UnknownVarFromCalendar_Int_1 == -1)
         {
            goToDay(UnknownVarFromCalendar_MainWindow_1.currentDay);
         }
         prepareImages();
         var _loc3_:Date = new Date();
         UnknownVarFromCalendar_Int_9 = _loc3_.getDate();
         UnknownVarFromCalendar_Timer_2 = new Timer(60000 * 5);
         UnknownVarFromCalendar_Timer_2.addEventListener("timer",onDateRefreshTimer);
         UnknownVarFromCalendar_Timer_2.start();
         onDateRefreshTimer(new TimerEvent("timer"));
         _questEngine.registerUpdateReceiver(this,1);
         UnknownVarFromCalendar_Timer_1 = new Timer(10,10);
      }
      
      public function close() : void
      {
         cleanUpEntityWindows();
         if(UnknownVarFromCalendar_CalendarBackgroundRenderer_1 != null)
         {
            UnknownVarFromCalendar_CalendarBackgroundRenderer_1.initializeImageChain(new Vector.<BitmapData>());
         }
      }
      
      public function refresh() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         for each(var _loc3_ in UnknownVarFromCalendar_Array_1)
         {
            _loc1_ = _loc3_.sortOrder - 1;
            _loc2_ = int(_loc3_.completedCampaign ? 2 : _states[_loc1_]);
            if(_loc2_ != _states[_loc1_])
            {
               retrieveEntityImageAsset(_loc3_.sortOrder,_loc2_);
               updateEntityIndicatorPanel(_loc1_,false);
               if(_loc2_ == 2 && UnknownVarFromCalendar_Int_6 == _loc1_)
               {
                  stopFlashing();
               }
            }
         }
         initializeBackgroundRendererIfAllImagesInCache();
         initializeEntitiesIfAllImagesInCache();
      }
      
      public function goToDay(param1:int) : void
      {
         scrollToIndex(Math.max(0,Math.min(param1 - 3,maxScrollRightIndex)));
      }
      
      private function prepareImages() : void
      {
         var _loc6_:int = 0;
         var _loc4_:int = 0;
         var _loc7_:int = 0;
         var _loc2_:Boolean = false;
         var _loc3_:int = 0;
         var _loc5_:int = 0;
         var _loc1_:int = Math.ceil(UnknownVarFromCalendar_Int_2 / 7) + 1;
         _bgAssetNameArray = new Array(_loc1_);
         _backgroundImageCache = new Vector.<BitmapData>(_loc1_);
         _graphicEntityCache = new Vector.<BitmapData>(UnknownVarFromCalendar_Int_2);
         _states = new Array(UnknownVarFromCalendar_Int_2);
         var _loc8_:Vector.<BitmapData> = new Vector.<BitmapData>();
         _loc6_ = 0;
         while(_loc6_ < _loc1_)
         {
            _loc8_.push(new BitmapData(640,320,false,16777215));
            _loc6_++;
         }
         UnknownVarFromCalendar_CalendarBackgroundRenderer_1.initializeImageChain(_loc8_);
         _loc4_ = firstBgIndex;
         while(_loc4_ <= lastBgIndex)
         {
            retrieveBackgroundImageAsset(_loc4_);
            _loc4_++;
         }
         UnknownVarFromCalendar_Map_1 = new Map();
         for each(var _loc9_ in UnknownVarFromCalendar_Array_1)
         {
            if(_loc9_.sortOrder <= _maximumEntities)
            {
               _loc7_ = _loc9_.completedCampaign ? 2 : 0;
               _loc2_ = _loc9_.sortOrder - 1 >= firstVisibleIndex && _loc9_.sortOrder - 1 <= lastVisibleIndex;
               retrieveEntityImageAsset(_loc9_.sortOrder,_loc7_,!_loc2_);
            }
         }
         if(UnknownVarFromCalendar_Array_1.length < UnknownVarFromCalendar_Int_2)
         {
            _loc3_ = _highestAvailableQuestIndex + 1;
            while(_loc3_ < UnknownVarFromCalendar_Int_2)
            {
               retrieveEntityImageAsset(_loc3_ + 1,1,_loc3_ > lastVisibleIndex);
               _loc3_++;
            }
         }
         _loc5_ = 0;
         while(_loc5_ < UnknownVarFromCalendar_Int_2)
         {
            if(_states[_loc5_] == null)
            {
               retrieveEntityImageAsset(_loc5_ + 1,3,_loc5_ < firstVisibleIndex || _loc5_ > lastVisibleIndex);
            }
            _loc5_++;
         }
      }
      
      private function initializeBackgroundRendererIfAllImagesInCache() : void
      {
         var _loc2_:int = 0;
         var _loc1_:BitmapData = null;
         if(!areViewableBackgroundBitmapsInitialized())
         {
            return;
         }
         var _loc4_:Array = [];
         var _loc5_:Vector.<BitmapData> = new Vector.<BitmapData>();
         _loc2_ = 0;
         while(_loc2_ < _backgroundImageCache.length)
         {
            _loc1_ = _backgroundImageCache[_loc2_];
            if(_loc1_ != null)
            {
               _loc5_.push(_loc1_);
            }
            else
            {
               _loc5_.push(new BitmapData(640,320,false,16777215));
               _loc4_.push(_loc2_);
            }
            _loc2_++;
         }
         UnknownVarFromCalendar_CalendarBackgroundRenderer_1.initializeImageChain(_loc5_);
         assignCurrentBackgroundSlice();
         for each(var _loc3_ in _loc4_)
         {
            retrieveBackgroundImageAsset(_loc3_);
         }
      }
      
      private function cleanUpEntityWindows() : void
      {
         if(_entityWindows == null)
         {
            return;
         }
         for each(var _loc1_ in _entityWindows)
         {
            UnknownVarFromCalendar_IWindowController_1_1.removeChild(_loc1_);
            _loc1_.dispose();
         }
         _entityWindows = null;
      }
      
      private function initializeEntitiesIfAllImagesInCache() : void
      {
         var _loc8_:IWindowController_1 = null;
         var _loc6_:int = 0;
         var _loc9_:IBitmapWrapperController = null;
         var _loc2_:IWindowModel = null;
         var _loc1_:IWindowModel = null;
         var _loc3_:IWindowModel = null;
         if(!areViewableEntityBitmapsInitialized())
         {
            return;
         }
         cleanUpEntityWindows();
         if(_entityWindows == null)
         {
            _entityWindows = new Vector.<IWindowController_1>();
         }
         var _loc5_:Array = [];
         for each(var _loc4_ in _graphicEntityCache)
         {
            _loc8_ = IWindowController_1(UnknownVarFromCalendar_IWindowController_1_2.clone());
            _loc6_ = int(_entityWindows.length);
            if(_loc4_ != null)
            {
               _loc9_ = _loc8_.findChildByName("entity_bitmap") as IBitmapWrapperController;
               _loc9_.width = _loc4_.width;
               _loc9_.height = _loc4_.height;
               _loc9_.bitmap = _loc4_.clone();
            }
            else
            {
               _loc5_.push(_loc6_);
            }
            _loc2_ = _loc8_.findChildByName("entity_mouse_region");
            _loc2_.procedure = entityMouseRegionWindowProcedure;
            if(_states[_loc6_] == 1 || _states[_loc6_] == 2 || _states[_loc6_] == 3)
            {
               _loc2_.visible = false;
            }
            _loc8_.visible = true;
            UnknownVarFromCalendar_IWindowController_1_1.addChild(_loc8_);
            _entityWindows.push(_loc8_);
            updateEntityIndicatorPanel(_loc6_,false);
         }
         repositionEntityWrappers();
         updateEntityVisibilities();
         _loc1_ = UnknownVarFromCalendar_IWindowController_1_1.findChildByName("stripe_mask_left");
         UnknownVarFromCalendar_IWindowController_1_1.setChildIndex(_loc1_,UnknownVarFromCalendar_IWindowController_1_1.numChildren - 1);
         _loc1_ = UnknownVarFromCalendar_IWindowController_1_1.findChildByName("stripe_mask_right");
         UnknownVarFromCalendar_IWindowController_1_1.setChildIndex(_loc1_,UnknownVarFromCalendar_IWindowController_1_1.numChildren - 1);
         _loc3_ = UnknownVarFromCalendar_IWindowController_1_1.findChildByName("button_left");
         UnknownVarFromCalendar_IWindowController_1_1.setChildIndex(_loc3_,UnknownVarFromCalendar_IWindowController_1_1.numChildren - 1);
         _loc3_ = UnknownVarFromCalendar_IWindowController_1_1.findChildByName("button_right");
         UnknownVarFromCalendar_IWindowController_1_1.setChildIndex(_loc3_,UnknownVarFromCalendar_IWindowController_1_1.numChildren - 1);
         for each(var _loc7_ in _loc5_)
         {
            retrieveEntityImageAsset(_loc7_ + 1,_states[_loc7_]);
         }
         if(_states[UnknownVarFromCalendar_MainWindow_1.currentDay - 1] == 0)
         {
            startFlashingAtIndex(UnknownVarFromCalendar_MainWindow_1.currentDay - 1);
         }
      }
      
      private function get firstVisibleIndex() : int
      {
         var _loc1_:int = UnknownVarFromCalendar_Int_1 - 1;
         return _loc1_ < 0 ? 0 : _loc1_;
      }
      
      private function get lastVisibleIndex() : int
      {
         var _loc2_:int = UnknownVarFromCalendar_Int_1 + 7 + 1;
         var _loc1_:int = UnknownVarFromCalendar_Int_2 - 1;
         return _loc2_ > _loc1_ ? _loc1_ : _loc2_;
      }
      
      private function areViewableEntityBitmapsInitialized() : Boolean
      {
         var _loc1_:int = 0;
         if(_graphicEntityCache == null)
         {
            return false;
         }
         _loc1_ = firstVisibleIndex;
         while(_loc1_ <= lastVisibleIndex)
         {
            if(_graphicEntityCache[_loc1_] == null)
            {
               return false;
            }
            _loc1_++;
         }
         return true;
      }
      
      private function get firstBgIndex() : int
      {
         var _loc2_:int = getBackgroundSliceOffset(UnknownVarFromCalendar_Int_1);
         var _loc1_:int = UnknownVarFromCalendar_CalendarBackgroundRenderer_1.getImageIndexForOffset(_loc2_);
         return _loc1_ < 0 ? 0 : _loc1_;
      }
      
      private function get lastBgIndex() : int
      {
         var _loc1_:int = getBackgroundSliceOffset(UnknownVarFromCalendar_Int_1);
         return UnknownVarFromCalendar_CalendarBackgroundRenderer_1.getImageIndexForOffset(_loc1_ + 640);
      }
      
      private function areViewableBackgroundBitmapsInitialized() : Boolean
      {
         var _loc1_:int = 0;
         if(_backgroundImageCache == null)
         {
            return false;
         }
         var _loc2_:int = getBackgroundSliceOffset(UnknownVarFromCalendar_Int_1);
         _loc1_ = firstBgIndex;
         while(_loc1_ <= lastBgIndex)
         {
            if(_backgroundImageCache[_loc1_] == null)
            {
               return false;
            }
            _loc1_++;
         }
         return true;
      }
      
      private function updateEntityIndicatorPanel(param1:int, param2:Boolean) : void
      {
         var _loc6_:BitmapData = null;
         var _loc7_:String = null;
         if(_entityWindows == null || _entityWindows.length < param1 - 1)
         {
            return;
         }
         var _loc3_:UnknownICoreWindowComponents6 = UnknownICoreWindowComponents6(_entityWindows[param1].findChildByName("entity_indicator"));
         var _loc5_:uint = uint(CalendarEntityStateEnums.INDICATOR_COLOR[_states[param1]]);
         if(param2)
         {
            _loc5_ += 2105376;
         }
         if(UnknownVarFromCalendar_Int_6 != param1)
         {
            _loc3_.color = _loc5_;
         }
         var _loc9_:IBitmapWrapperController = IBitmapWrapperController(_entityWindows[param1].findChildByName("entity_indicator_status"));
         if(_states[param1] == 2)
         {
            _loc6_ = BitmapData(_questEngine.assets.getAssetByName("calendar_quest_complete").content);
            _loc9_.width = _loc6_.width;
            _loc9_.height = _loc6_.height;
            _loc9_.bitmap = _loc6_.clone();
         }
         else
         {
            _loc9_.bitmap = null;
         }
         var _loc4_:ITextWindow = _loc3_.findChildByName("entity_indicator_text") as ITextWindow;
         var _loc8_:QuestMessageData = getQuestByEntityWindowIndex(param1);
         if(_loc8_ != null)
         {
            _loc4_.text = _questEngine.getCampaignName(_loc8_);
         }
         else
         {
            _loc7_ = QuestMessageData.getCampaignLocalizationKeyForCode(_questEngine.getSeasonalCampaignCodePrefix() + "_" + (param1 + 1));
            _loc4_.text = _questEngine.getCampaignNameByCode(_loc7_);
         }
      }
      
      private function retrieveEntityImageAsset(param1:int, param2:int, param3:Boolean = false) : void
      {
         var _loc4_:String = "day" + param1;
         switch(param2)
         {
            case 0:
            case 1:
            case 3:
               _loc4_ += "_uncomplete";
               break;
            case 2:
               _loc4_ += "_completed";
         }
         _states[param1 - 1] = param2;
         UnknownVarFromCalendar_Map_1[_loc4_] = param1 - 1;
         var _loc5_:ISoundAsset = _questEngine.assets.getAssetByName(_loc4_);
         if(_loc5_ != null)
         {
            assignEntityBitmapToCacheByAssetName(_loc4_);
            initializeEntitiesIfAllImagesInCache();
         }
         else if(!param3)
         {
            loadAssetFromImageGallery(_loc4_,onEntityImageAssetDownloaded);
         }
      }
      
      private function retrieveBackgroundImageAsset(param1:int) : void
      {
         var _loc2_:String = "background_" + (param1 + 1);
         _bgAssetNameArray[param1] = _loc2_;
         var _loc3_:ISoundAsset = _questEngine.assets.getAssetByName(_loc2_);
         if(_loc3_ != null)
         {
            assignBackgroundBitmapToCacheByAssetName(_loc2_);
            initializeBackgroundRendererIfAllImagesInCache();
         }
         else
         {
            loadAssetFromImageGallery(_loc2_,onBackgroundImageAssetDownloaded);
         }
      }
      
      private function loadAssetFromImageGallery(param1:String, param2:Function) : void
      {
         var _loc5_:String = getImageGalleryHost() + param1 + ".png";
         var _loc3_:URLRequest = new URLRequest(_loc5_);
         var _loc4_:AssetLoaderStruct = _questEngine.assets.loadAssetFromFile(param1,_loc3_,"image/png");
         if(_loc4_ && !_loc4_.disposed)
         {
            _loc4_.addEventListener("AssetLoaderEventComplete",param2);
            _loc4_.addEventListener("AssetLoaderEventError",param2);
         }
      }
      
      private function onBackgroundImageAssetDownloaded(param1:AssetLoaderEvent) : void
      {
         var _loc2_:AssetLoaderStruct = param1.target as AssetLoaderStruct;
         if(_loc2_ != null)
         {
            assignBackgroundBitmapToCacheByAssetName(_loc2_.assetName);
         }
         initializeBackgroundRendererIfAllImagesInCache();
      }
      
      private function onEntityImageAssetDownloaded(param1:AssetLoaderEvent) : void
      {
         var _loc2_:AssetLoaderStruct = param1.target as AssetLoaderStruct;
         if(_loc2_ != null)
         {
            assignEntityBitmapToCacheByAssetName(_loc2_.assetName);
         }
         initializeEntitiesIfAllImagesInCache();
      }
      
      private function assignBackgroundBitmapToCacheByAssetName(param1:String) : void
      {
         var _loc2_:int = int(_bgAssetNameArray.indexOf(param1));
         if(_loc2_ == -1)
         {
            return;
         }
         var _loc3_:ISoundAsset = _questEngine.assets.getAssetByName(param1);
         _backgroundImageCache[_loc2_] = _loc3_ != null ? _loc3_.content as BitmapData : new BitmapData(640,320);
      }
      
      private function assignEntityBitmapToCacheByAssetName(param1:String) : void
      {
         var _loc3_:ISoundAsset = _questEngine.assets.getAssetByName(param1);
         var _loc2_:int = int(UnknownVarFromCalendar_Map_1[param1]);
         if(_loc2_ == -1 || _loc2_ >= _graphicEntityCache.length)
         {
            return;
         }
         _graphicEntityCache[_loc2_] = _loc3_ != null ? _loc3_.content as BitmapData : new BitmapData(1,1,true,0);
      }
      
      private function repositionEntityWrappers() : void
      {
         var _loc1_:int = 0;
         if(_entityWindows == null)
         {
            return;
         }
         _loc1_ = 0;
         while(_loc1_ < _entityWindows.length)
         {
            _entityWindows[_loc1_].x = (_loc1_ - UnknownVarFromCalendar_Int_1) * 80 + UnknownVarFromCalendar_Int_3 + 37;
            _loc1_++;
         }
      }
      
      private function getBackgroundSliceOffset(param1:int) : int
      {
         return param1 * 80;
      }
      
      private function assignCurrentBackgroundSlice() : void
      {
         var _loc1_:BitmapData = UnknownVarFromCalendar_CalendarBackgroundRenderer_1.getSlice(getBackgroundSliceOffset(UnknownVarFromCalendar_Int_1),UnknownVarFromCalendar_IWindowController_1_1.width);
         UnknownVarFromCalendar_IBitmapWrapperController_1.x = 0;
         UnknownVarFromCalendar_IBitmapWrapperController_1.width = _loc1_.width;
         UnknownVarFromCalendar_IBitmapWrapperController_1.height = _loc1_.height;
         UnknownVarFromCalendar_IBitmapWrapperController_1.bitmap = _loc1_.clone();
      }
      
      private function assignScrollableBackgroundSlice(param1:int) : void
      {
         var _loc3_:BitmapData = null;
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         var _loc6_:int = 0;
         if(param1 < UnknownVarFromCalendar_Int_1)
         {
            _loc5_ = UnknownVarFromCalendar_Int_1 - param1;
            _loc4_ = getBackgroundSliceOffset(param1);
            _loc3_ = UnknownVarFromCalendar_CalendarBackgroundRenderer_1.getSlice(_loc4_,UnknownVarFromCalendar_IWindowController_1_1.width + 80 * _loc5_);
            UnknownVarFromCalendar_Int_5 = -(80 * _loc5_);
         }
         else
         {
            _loc2_ = param1 - UnknownVarFromCalendar_Int_1;
            _loc6_ = 80 * _loc2_ + UnknownVarFromCalendar_IWindowController_1_1.width;
            _loc3_ = UnknownVarFromCalendar_CalendarBackgroundRenderer_1.getSlice(getBackgroundSliceOffset(UnknownVarFromCalendar_Int_1),_loc6_);
            UnknownVarFromCalendar_Int_5 = 0;
         }
         UnknownVarFromCalendar_IBitmapWrapperController_1.x = UnknownVarFromCalendar_Int_5;
         if(_loc3_ != null)
         {
            UnknownVarFromCalendar_IBitmapWrapperController_1.width = _loc3_.width;
            UnknownVarFromCalendar_IBitmapWrapperController_1.height = _loc3_.height;
            UnknownVarFromCalendar_IBitmapWrapperController_1.bitmap = _loc3_.clone();
         }
      }
      
      private function repositionBackgroundSlice() : void
      {
         UnknownVarFromCalendar_IBitmapWrapperController_1.x = UnknownVarFromCalendar_Int_5 + UnknownVarFromCalendar_Int_3;
      }
      
      private function scrollToIndex(param1:int) : void
      {
         if(param1 < 0 || param1 >= UnknownVarFromCalendar_Int_2)
         {
            return;
         }
         if(UnknownVarFromCalendar_Timer_1 != null && UnknownVarFromCalendar_Timer_1.running)
         {
            return;
         }
         if(!areViewableEntityBitmapsInitialized())
         {
            UnknownVarFromCalendar_Int_1 = param1;
            enableScrollArrowsByViewIndex();
            return;
         }
         var _loc2_:int = UnknownVarFromCalendar_Int_1;
         UnknownVarFromCalendar_Int_1 = param1;
         if(areViewableBackgroundBitmapsInitialized())
         {
            UnknownVarFromCalendar_Int_1 = _loc2_;
            assignScrollableBackgroundSlice(param1);
            updateEntityVisibilities(true,param1 - UnknownVarFromCalendar_Int_1);
            UnknownVarFromCalendar_Int_4 = -(80 * (param1 - UnknownVarFromCalendar_Int_1)) / 10;
            UnknownVarFromCalendar_Timer_1 = new Timer(10,10);
            UnknownVarFromCalendar_Timer_1.addEventListener("timer",onAnimateScroll);
            UnknownVarFromCalendar_Timer_1.addEventListener("timerComplete",onAnimateScroll);
            UnknownVarFromCalendar_Timer_1.start();
         }
         else
         {
            UnknownVarFromCalendar_Int_1 = _loc2_;
         }
      }
      
      private function get maxScrollRightIndex() : int
      {
         return _maximumEntities - 7;
      }
      
      private function enableScrollArrowsByViewIndex() : void
      {
         if(UnknownVarFromCalendar_Int_1 > 0)
         {
            UnknownVarFromCalendar_CalendarArrowButton_1.activate();
         }
         else
         {
            UnknownVarFromCalendar_CalendarArrowButton_1.deactivate();
         }
         if(UnknownVarFromCalendar_Int_1 < Math.min(UnknownVarFromCalendar_Int_2 - 3 - 1,maxScrollRightIndex))
         {
            UnknownVarFromCalendar_CalendarArrowButton_2.activate();
         }
         else
         {
            UnknownVarFromCalendar_CalendarArrowButton_2.deactivate();
         }
      }
      
      private function updateEntityVisibilities(param1:Boolean = false, param2:int = 0) : void
      {
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         var _loc5_:int = 0;
         if(_entityWindows != null)
         {
            _loc4_ = UnknownVarFromCalendar_Int_1 - 1;
            if(param1 && param2 < 0)
            {
               _loc4_ += param2;
            }
            _loc3_ = UnknownVarFromCalendar_Int_1 + 7 + 1;
            if(param1 && param2 > 0)
            {
               _loc3_ += param2;
            }
            _loc5_ = 0;
            while(_loc5_ < _entityWindows.length)
            {
               if(_loc5_ < _loc4_ || _loc5_ > _loc3_)
               {
                  _entityWindows[_loc5_].visible = false;
               }
               else
               {
                  _entityWindows[_loc5_].visible = true;
                  if(_loc5_ == _loc4_ || _loc5_ == _loc3_)
                  {
                     _entityWindows[_loc5_].getChildByName("entity_mouse_region").visible = false;
                  }
                  else if(_states[_loc5_] == 0)
                  {
                     _entityWindows[_loc5_].getChildByName("entity_mouse_region").visible = true;
                  }
               }
               _loc5_++;
            }
         }
      }
      
      private function onAnimateScroll(param1:TimerEvent) : void
      {
         switch(param1.type)
         {
            case "timer":
               UnknownVarFromCalendar_Int_3 += UnknownVarFromCalendar_Int_4;
               repositionBackgroundSlice();
               repositionEntityWrappers();
               break;
            case "timerComplete":
               UnknownVarFromCalendar_Int_3 = 0;
               if(UnknownVarFromCalendar_Int_4 > 0)
               {
                  UnknownVarFromCalendar_Int_1 -= 1;
               }
               else
               {
                  UnknownVarFromCalendar_Int_1 += 1;
               }
               assignCurrentBackgroundSlice();
               repositionEntityWrappers();
               enableScrollArrowsByViewIndex();
               updateEntityVisibilities();
               UnknownVarFromCalendar_Timer_1.removeEventListener("timer",onAnimateScroll);
               UnknownVarFromCalendar_Timer_1.removeEventListener("timerComplete",onAnimateScroll);
         }
      }
      
      private function scrollArrowProcedure(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type == "WME_DOWN")
         {
            switch(param2.name)
            {
               case "button_left":
                  UnknownVarFromCalendar_Boolean_1 = true;
                  break;
               case "button_right":
                  UnknownVarFromCalendar_Boolean_2 = true;
            }
         }
         if(param1.type == "WME_UP" || param1.type == "WME_UP_OUTSIDE")
         {
            UnknownVarFromCalendar_Boolean_1 = false;
            UnknownVarFromCalendar_Boolean_2 = false;
         }
      }
      
      private function entityMouseRegionWindowProcedure(param1:WindowEvent, param2:IWindowModel) : void
      {
         var _loc3_:int = 0;
         var _loc4_:QuestMessageData = null;
         if(param2.name == "entity_mouse_region")
         {
            _loc3_ = int(_entityWindows.indexOf(param2.parent as IWindowController_1));
            if(param1.type == "WME_CLICK")
            {
               _loc4_ = getQuestByEntityWindowIndex(_loc3_);
               if(_loc4_ != null)
               {
                  _questEngine.questController.questDetails.openDetails(_loc4_,true);
               }
            }
            if(param1.type == "WME_OVER")
            {
               updateEntityIndicatorPanel(_loc3_,true);
               UnknownVarFromCalendar_Int_8 = _loc3_;
            }
            if(param1.type == "WME_OUT")
            {
               updateEntityIndicatorPanel(_loc3_,false);
               UnknownVarFromCalendar_Int_8 = -1;
            }
         }
      }
      
      private function getQuestByEntityWindowIndex(param1:int) : QuestMessageData
      {
         for each(var _loc2_ in UnknownVarFromCalendar_Array_1)
         {
            if(_loc2_.sortOrder - 1 == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function update(param1:uint) : void
      {
         var _loc5_:int = 0;
         var _loc4_:Number = NaN;
         var _loc2_:UnknownICoreWindowComponents6 = null;
         var _loc3_:Number = NaN;
         if(_entityWindows != null && UnknownVarFromCalendar_Int_6 != -1)
         {
            _loc5_ = int(CalendarEntityStateEnums.INDICATOR_COLOR[_states[UnknownVarFromCalendar_Int_6]]);
            _loc4_ = UnknownVarFromCalendar_Int_7 % 2000 / 2000;
            _loc4_ -= 1;
            _loc4_ = Math.abs(2 * (_loc4_ > 0.5 ? _loc4_ : _loc4_));
            _loc2_ = UnknownICoreWindowComponents6(_entityWindows[UnknownVarFromCalendar_Int_6].findChildByName("entity_indicator"));
            if(_loc2_)
            {
               _loc3_ = _loc4_ * 100;
               if(UnknownVarFromCalendar_Int_8 == UnknownVarFromCalendar_Int_6)
               {
                  _loc3_ += 20;
               }
               _loc2_.color = adjustBrightness(_loc5_,_loc3_);
            }
            UnknownVarFromCalendar_Int_7 += param1;
         }
         if(UnknownVarFromCalendar_Timer_1 != null)
         {
            if(UnknownVarFromCalendar_Boolean_1 && !UnknownVarFromCalendar_Timer_1.running && UnknownVarFromCalendar_Int_3 == 0)
            {
               if(UnknownVarFromCalendar_Int_1 > 0 && !UnknownVarFromCalendar_CalendarArrowButton_1.isInactive())
               {
                  scrollToIndex(UnknownVarFromCalendar_Int_1 - 1);
               }
            }
            if(UnknownVarFromCalendar_Boolean_2 && !UnknownVarFromCalendar_Timer_1.running && UnknownVarFromCalendar_Int_3 == 0)
            {
               if(UnknownVarFromCalendar_Int_1 < _highestAvailableQuestIndex && !UnknownVarFromCalendar_CalendarArrowButton_2.isInactive())
               {
                  scrollToIndex(UnknownVarFromCalendar_Int_1 + 1);
               }
            }
         }
      }
      
      private function startFlashingAtIndex(param1:int) : void
      {
         if(param1 < 0 || param1 >= UnknownVarFromCalendar_Int_2)
         {
            return;
         }
         UnknownVarFromCalendar_Int_6 = param1;
         UnknownVarFromCalendar_Int_7 = 0;
      }
      
      private function stopFlashing() : void
      {
         UnknownVarFromCalendar_Int_6 = -1;
      }
      
      private function onDateRefreshTimer(param1:TimerEvent) : void
      {
         var _loc2_:Date = new Date();
         if(UnknownVarFromCalendar_Int_9 != _loc2_.getDate())
         {
            _questEngine.requestSeasonalQuests();
         }
         UnknownVarFromCalendar_Int_9 = _loc2_.getDate();
      }
   }
}

