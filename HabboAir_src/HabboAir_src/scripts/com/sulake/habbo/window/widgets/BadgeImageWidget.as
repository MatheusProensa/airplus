package com.sulake.habbo.window.widgets
{
   import com.sulake.core.assets.ISoundAsset;
   import com.sulake.core.assets.UnknownICoreAssets1;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.IWidgetWindowController;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.iterators.EmptyIterator;
   import com.sulake.core.window.utils.IIterator;
   import com.sulake.core.window.utils.PropertyStruct;
   import com.sulake.core.window.utils.UnknownICoreWindowUtils4;
   import com.sulake.habbo.communication.messages.incoming.users.GroupDetailsChangedMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.users.HabboGroupBadgesMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.users.GetHabboGroupDetailsMessageComposer;
   import com.sulake.habbo.window.HabboWindowManagerComponent;
   import com.sulake.habbo.window.enum.UnknownHabboWindowEnum2;
   import flash.display.BitmapData;
   import flash.events.TimerEvent;
   import flash.filters.ColorMatrixFilter;
   import flash.filters.GlowFilter;
   import flash.geom.Point;
   import flash.utils.Timer;
   
   public class BadgeImageWidget implements IBadgeImageWidget, UnknownICoreAssets1
   {
      public static const TYPE:String = "badge_image";
      
      private static const UnknownConstFromBadgeImageWidget_String_1:String = "badge_image:type";
      
      private static const UnknownConstFromBadgeImageWidget_String_2:String = "badge_image:badge_id";
      
      private static const NO_GLOW_COLOR:int = -1;
      
      private static const GLOW_DURATION_MS:int = 1000;
      
      private static const GLOW_TIMER_DELAY_MS:int = 16;
      
      private static const PENDING_GLOW_MAX_WAIT_MS:int = 5000;
      
      private static const UnknownConstFromBadgeImageWidget_Number_1:Number = 0.7;
      
      private static const INNER_GLOW_MAX_ALPHA:Number = 0.22;
      
      private static const COLOR_MATRIX_MIX_MAX:Number = 0.48;
      
      private static const COLOR_MATRIX_OFFSET_MAX:Number = 80;
      
      private static const TYPE_DEFAULT:PropertyStruct = new PropertyStruct("badge_image:type","normal","String",false,UnknownHabboWindowEnum2.ALL);
      
      private static const ID_DEFAULT:PropertyStruct = new PropertyStruct("badge_image:badge_id","","String");
      
      private var _disposed:Boolean;
      
      private var UnknownVarFromBadgeImageWidget_IWidgetWindowController_1:IWidgetWindowController;
      
      private var _windowManager:HabboWindowManagerComponent;
      
      private var UnknownVarFromBadgeImageWidget_Boolean_1:Boolean;
      
      private var UnknownVarFromBadgeImageWidget_IWindowController_1_1:IWindowController_1;
      
      private var _bitmap:IStaticBitmapWrapperWindow;
      
      private var UnknownVarFromBadgeImageWidget_IRegionWindow_1:IRegionWindow;
      
      private var _type:String = String(TYPE_DEFAULT.value);
      
      private var _badgeId:String = String(ID_DEFAULT.value);
      
      private var _groupId:int;
      
      private var _glowColor:int = -1;
      
      private var UnknownVarFromBadgeImageWidget_GroupDetailsChangedMessageEvent_1:GroupDetailsChangedMessageEvent;
      
      private var UnknownVarFromBadgeImageWidget_HabboGroupBadgesMessageEvent_1:HabboGroupBadgesMessageEvent;
      
      private var UnknownVarFromBadgeImageWidget_Timer_1:Timer;
      
      private var UnknownVarFromBadgeImageWidget_Boolean_2:Boolean;
      
      private var _glowRestoreFilters:Array;
      
      private var UnknownVarFromBadgeImageWidget_Timer_2:Timer;
      
      private var _pendingGlowAssetUri:String;
      
      private var _pendingGlowColor:int = -1;
      
      private var UnknownVarFromBadgeImageWidget_Int_1:int = 1000;
      
      public function BadgeImageWidget(param1:IWidgetWindowController, param2:HabboWindowManagerComponent)
      {
         super();
         UnknownVarFromBadgeImageWidget_IWidgetWindowController_1 = param1;
         _windowManager = param2;
         UnknownVarFromBadgeImageWidget_IWindowController_1_1 = _windowManager.buildFromXML(_windowManager.assets.getAssetByName("badge_image_xml").content as XML) as IWindowController_1;
         _bitmap = UnknownVarFromBadgeImageWidget_IWindowController_1_1.findChildByName("bitmap") as IStaticBitmapWrapperWindow;
         UnknownVarFromBadgeImageWidget_IRegionWindow_1 = UnknownVarFromBadgeImageWidget_IWindowController_1_1.findChildByName("region") as IRegionWindow;
         UnknownVarFromBadgeImageWidget_IRegionWindow_1.addEventListener("WME_CLICK",onClick);
         UnknownVarFromBadgeImageWidget_IWidgetWindowController_1.rootWindow = UnknownVarFromBadgeImageWidget_IWindowController_1_1;
         UnknownVarFromBadgeImageWidget_IWindowController_1_1.width = UnknownVarFromBadgeImageWidget_IWidgetWindowController_1.width;
         UnknownVarFromBadgeImageWidget_IWindowController_1_1.height = UnknownVarFromBadgeImageWidget_IWidgetWindowController_1.height;
      }
      
      private static function easeInOutCubic(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         var _loc5_:Number = param1 / param4;
         var _loc6_:Number = -(_loc5_ * 1.75 - 0.7) * (_loc5_ * 1.75 - 0.7) + 1;
         return param2 + param3 * _loc6_;
      }
      
      private static function clamp01(param1:Number) : Number
      {
         if(param1 < 0)
         {
            return 0;
         }
         if(param1 > 1)
         {
            return 1;
         }
         return param1;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            clearGlow();
            groupId = 0;
            if(UnknownVarFromBadgeImageWidget_IRegionWindow_1 != null)
            {
               UnknownVarFromBadgeImageWidget_IRegionWindow_1.removeEventListener("WME_CLICK",onClick);
               UnknownVarFromBadgeImageWidget_IRegionWindow_1.dispose();
               UnknownVarFromBadgeImageWidget_IRegionWindow_1 = null;
            }
            _bitmap = null;
            _glowRestoreFilters = null;
            if(UnknownVarFromBadgeImageWidget_IWindowController_1_1 != null)
            {
               UnknownVarFromBadgeImageWidget_IWindowController_1_1.dispose();
               UnknownVarFromBadgeImageWidget_IWindowController_1_1 = null;
            }
            if(UnknownVarFromBadgeImageWidget_IWidgetWindowController_1 != null)
            {
               UnknownVarFromBadgeImageWidget_IWidgetWindowController_1.rootWindow = null;
               UnknownVarFromBadgeImageWidget_IWidgetWindowController_1 = null;
            }
            _windowManager = null;
            _disposed = true;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get iterator() : IIterator
      {
         return EmptyIterator.INSTANCE;
      }
      
      public function get properties() : Array
      {
         var _loc2_:Array = [];
         if(_disposed)
         {
            return _loc2_;
         }
         _loc2_.push(TYPE_DEFAULT.withValue(_type));
         _loc2_.push(ID_DEFAULT.withValue(_badgeId));
         for each(var _loc1_ in _bitmap.properties)
         {
            if(_loc1_.key != "asset_uri")
            {
               _loc2_.push(_loc1_.withNameSpace("badge_image"));
            }
         }
         return _loc2_;
      }
      
      public function set properties(param1:Array) : void
      {
         UnknownVarFromBadgeImageWidget_Boolean_1 = true;
         var _loc3_:Array = [];
         for each(var _loc2_ in param1)
         {
            switch(_loc2_.key)
            {
               case "badge_image:type":
                  type = String(_loc2_.value);
                  break;
               case "badge_image:badge_id":
                  badgeId = String(_loc2_.value);
            }
            if(_loc2_.key != "badge_image:asset_uri")
            {
               _loc3_.push(_loc2_.withoutNameSpace());
            }
         }
         _bitmap.properties = _loc3_;
         UnknownVarFromBadgeImageWidget_Boolean_1 = false;
         refresh();
      }
      
      public function get type() : String
      {
         return _type;
      }
      
      public function set type(param1:String) : void
      {
         _type = param1;
         refresh();
      }
      
      public function get badgeId() : String
      {
         return _badgeId;
      }
      
      public function set badgeId(param1:String) : void
      {
         if(_badgeId != param1)
         {
            clearGlow();
            _glowColor = -1;
         }
         _badgeId = param1;
         refresh();
      }
      
      public function get groupId() : int
      {
         return _groupId;
      }
      
      public function set groupId(param1:int) : void
      {
         _groupId = param1;
         var _loc2_:Boolean = _type == "group" && _groupId > 0;
         if(_windowManager != null && _windowManager.communication != null)
         {
            if(!_loc2_ && UnknownVarFromBadgeImageWidget_HabboGroupBadgesMessageEvent_1 != null)
            {
               _windowManager.communication.removeHabboConnectionMessageEvent(UnknownVarFromBadgeImageWidget_GroupDetailsChangedMessageEvent_1);
               _windowManager.communication.removeHabboConnectionMessageEvent(UnknownVarFromBadgeImageWidget_HabboGroupBadgesMessageEvent_1);
               UnknownVarFromBadgeImageWidget_GroupDetailsChangedMessageEvent_1 = null;
               UnknownVarFromBadgeImageWidget_HabboGroupBadgesMessageEvent_1 = null;
            }
            else if(_loc2_ && UnknownVarFromBadgeImageWidget_HabboGroupBadgesMessageEvent_1 == null)
            {
               UnknownVarFromBadgeImageWidget_GroupDetailsChangedMessageEvent_1 = new GroupDetailsChangedMessageEvent(onGroupDetailsChanged);
               UnknownVarFromBadgeImageWidget_HabboGroupBadgesMessageEvent_1 = new HabboGroupBadgesMessageEvent(onHabboGroupBadges);
               _windowManager.communication.addHabboConnectionMessageEvent(UnknownVarFromBadgeImageWidget_GroupDetailsChangedMessageEvent_1);
               _windowManager.communication.addHabboConnectionMessageEvent(UnknownVarFromBadgeImageWidget_HabboGroupBadgesMessageEvent_1);
            }
         }
      }
      
      public function get glowColor() : int
      {
         return _glowColor;
      }
      
      public function set glowColor(param1:int) : void
      {
         _glowColor = param1;
         if(_glowColor < 0 && (UnknownVarFromBadgeImageWidget_Boolean_2 || _pendingGlowAssetUri != null))
         {
            clearGlow();
         }
      }
      
      public function get bitmapData() : BitmapData
      {
         return UnknownICoreWindowUtils4(_bitmap).bitmapData;
      }
      
      public function get pivotPoint() : uint
      {
         return _bitmap.pivotPoint;
      }
      
      public function set pivotPoint(param1:uint) : void
      {
         _bitmap.pivotPoint = param1;
         _bitmap.invalidate();
      }
      
      public function get stretchedX() : Boolean
      {
         return _bitmap.stretchedX;
      }
      
      public function set stretchedX(param1:Boolean) : void
      {
         _bitmap.stretchedX = param1;
         _bitmap.invalidate();
      }
      
      public function get stretchedY() : Boolean
      {
         return _bitmap.stretchedY;
      }
      
      public function set stretchedY(param1:Boolean) : void
      {
         _bitmap.stretchedY = param1;
         _bitmap.invalidate();
      }
      
      public function get zoomX() : Number
      {
         return _bitmap.zoomX;
      }
      
      public function set zoomX(param1:Number) : void
      {
         _bitmap.zoomX = param1;
         _bitmap.invalidate();
      }
      
      public function get zoomY() : Number
      {
         return _bitmap.zoomY;
      }
      
      public function set zoomY(param1:Number) : void
      {
         _bitmap.zoomY = param1;
         _bitmap.invalidate();
      }
      
      public function get greyscale() : Boolean
      {
         return _bitmap.greyscale;
      }
      
      public function set greyscale(param1:Boolean) : void
      {
         _bitmap.greyscale = param1;
         _bitmap.invalidate();
      }
      
      public function get etchingColor() : uint
      {
         return _bitmap.etchingColor;
      }
      
      public function set etchingColor(param1:uint) : void
      {
         _bitmap.etchingColor = param1;
         _bitmap.invalidate();
      }
      
      public function get fitSizeToContents() : Boolean
      {
         return _bitmap.fitSizeToContents;
      }
      
      public function set fitSizeToContents(param1:Boolean) : void
      {
         _bitmap.fitSizeToContents = param1;
         _bitmap.invalidate();
      }
      
      private function onClick(param1:WindowMouseEvent) : void
      {
         if(_groupId > 0)
         {
            _windowManager.communication.connection.send(new GetHabboGroupDetailsMessageComposer(_groupId,true));
         }
      }
      
      public function refresh() : void
      {
         if(UnknownVarFromBadgeImageWidget_Boolean_1)
         {
            return;
         }
         var _loc1_:String = assetUri;
         if(_pendingGlowAssetUri != null && _pendingGlowAssetUri != _loc1_)
         {
            cancelPendingGlow();
         }
         _bitmap.assetUri = _loc1_;
         _bitmap.blend = UnknownVarFromBadgeImageWidget_IWidgetWindowController_1.blend;
         _bitmap.invalidate();
      }
      
      public function playGlow(param1:uint, param2:int = 500, param3:Number = 1.04) : void
      {
         if(_disposed || _bitmap == null || UnknownVarFromBadgeImageWidget_IWidgetWindowController_1 == null)
         {
            return;
         }
         _glowColor = param1 & 0xFFFFFF;
         if(param2 <= 0)
         {
            param2 = 1000;
         }
         clearGlow();
         var _loc4_:String = assetUri;
         if(_loc4_ == null || _loc4_.length == 0 || _windowManager == null || _windowManager.resourceManager == null)
         {
            return;
         }
         _pendingGlowAssetUri = _loc4_;
         _pendingGlowColor = _glowColor;
         UnknownVarFromBadgeImageWidget_Int_1 = param2;
         UnknownVarFromBadgeImageWidget_Timer_2 = new Timer(5000,1);
         UnknownVarFromBadgeImageWidget_Timer_2.addEventListener("timerComplete",onPendingGlowTimeout);
         UnknownVarFromBadgeImageWidget_Timer_2.start();
         _windowManager.resourceManager.retrieveAsset(_pendingGlowAssetUri,this);
      }
      
      public function clearGlow() : void
      {
         cancelPendingGlow();
         if(UnknownVarFromBadgeImageWidget_Timer_1 != null)
         {
            UnknownVarFromBadgeImageWidget_Timer_1.stop();
            UnknownVarFromBadgeImageWidget_Timer_1.removeEventListener("timer",onGlowTick);
            UnknownVarFromBadgeImageWidget_Timer_1.removeEventListener("timerComplete",onGlowComplete);
            UnknownVarFromBadgeImageWidget_Timer_1 = null;
         }
         if(!UnknownVarFromBadgeImageWidget_Boolean_2)
         {
            return;
         }
         if(UnknownVarFromBadgeImageWidget_IWidgetWindowController_1 != null)
         {
            UnknownVarFromBadgeImageWidget_IWidgetWindowController_1.filters = _glowRestoreFilters ?? [];
         }
         refresh();
         UnknownVarFromBadgeImageWidget_Boolean_2 = false;
      }
      
      public function receiveAsset(param1:ISoundAsset, param2:String) : void
      {
         if(_disposed || _pendingGlowAssetUri == null || _windowManager == null || _windowManager.resourceManager == null)
         {
            return;
         }
         if(!_windowManager.resourceManager.isSameAsset(_pendingGlowAssetUri,param2))
         {
            return;
         }
         if(_bitmap == null || _bitmap.assetUri != _pendingGlowAssetUri || _bitmap.bitmapData == null)
         {
            return;
         }
         var _loc3_:int = _pendingGlowColor;
         var _loc4_:int = UnknownVarFromBadgeImageWidget_Int_1;
         cancelPendingGlow();
         startGlowAnimation(uint(_loc3_),_loc4_);
      }
      
      private function get assetUri() : String
      {
         var _loc1_:String = "";
         if(_badgeId != null && _badgeId.length > 0)
         {
            switch(_type)
            {
               case "normal":
                  _loc1_ = "${image.library.url}album1584/" + _badgeId + ".png";
                  break;
               case "group":
                  _loc1_ = _windowManager.getProperty("group.badge.url").replace("%imagerdata%",_badgeId);
                  break;
               case "perk":
                  _loc1_ = "${image.library.url}perk/" + _badgeId + ".png";
            }
         }
         return _loc1_;
      }
      
      private function forceRefresh(param1:int, param2:String) : void
      {
         if(param1 != _groupId)
         {
            return;
         }
         _badgeId = param2;
         _windowManager.resourceManager.removeAsset(assetUri);
         refresh();
      }
      
      private function onGroupDetailsChanged(param1:GroupDetailsChangedMessageEvent) : void
      {
         forceRefresh(param1.groupId,_badgeId);
      }
      
      private function onHabboGroupBadges(param1:HabboGroupBadgesMessageEvent) : void
      {
         if(param1.badges.hasKey(_groupId))
         {
            forceRefresh(_groupId,param1.badges[_groupId]);
         }
      }
      
      private function applyGlowStrength(param1:Number) : void
      {
         if(UnknownVarFromBadgeImageWidget_IWidgetWindowController_1 == null)
         {
            return;
         }
         param1 = clamp01(param1);
         var _loc2_:Array = _glowRestoreFilters != null ? _glowRestoreFilters.concat() : [];
         if(param1 > 0.001 && _glowColor >= 0)
         {
            _loc2_.push(createOuterGlowFilter(uint(_glowColor),param1));
            _loc2_.push(createInnerGlowFilter(uint(_glowColor),param1));
            _loc2_.push(createColorTintFilter(uint(_glowColor),param1));
         }
         UnknownVarFromBadgeImageWidget_IWidgetWindowController_1.filters = _loc2_;
      }
      
      private function startGlowAnimation(param1:uint, param2:int) : void
      {
         _glowColor = param1 & 0xFFFFFF;
         _glowRestoreFilters = UnknownVarFromBadgeImageWidget_IWidgetWindowController_1.filters != null ? UnknownVarFromBadgeImageWidget_IWidgetWindowController_1.filters.concat() : [];
         UnknownVarFromBadgeImageWidget_Boolean_2 = true;
         applyGlowStrength(0);
         var _loc3_:int = Math.max(1,int(param2 / 16));
         UnknownVarFromBadgeImageWidget_Timer_1 = new Timer(16,_loc3_);
         UnknownVarFromBadgeImageWidget_Timer_1.addEventListener("timer",onGlowTick);
         UnknownVarFromBadgeImageWidget_Timer_1.addEventListener("timerComplete",onGlowComplete);
         UnknownVarFromBadgeImageWidget_Timer_1.start();
      }
      
      private function cancelPendingGlow() : void
      {
         if(UnknownVarFromBadgeImageWidget_Timer_2 != null)
         {
            UnknownVarFromBadgeImageWidget_Timer_2.stop();
            UnknownVarFromBadgeImageWidget_Timer_2.removeEventListener("timerComplete",onPendingGlowTimeout);
            UnknownVarFromBadgeImageWidget_Timer_2 = null;
         }
         _pendingGlowAssetUri = null;
         _pendingGlowColor = -1;
         UnknownVarFromBadgeImageWidget_Int_1 = 1000;
      }
      
      private function createOuterGlowFilter(param1:uint, param2:Number) : GlowFilter
      {
         return new GlowFilter(param1,0.7 * param2,4 + param2 * 4,4 + param2 * 4,1 + param2 * 1.2,2,false,false);
      }
      
      private function createInnerGlowFilter(param1:uint, param2:Number) : GlowFilter
      {
         return new GlowFilter(param1,0.22 * param2,2 + param2 * 2,2 + param2 * 2,0.8 + param2 * 0.6,1,true,false);
      }
      
      private function createColorTintFilter(param1:uint, param2:Number) : ColorMatrixFilter
      {
         var _loc3_:Number = (param1 >> 16 & 0xFF) / 255;
         var _loc4_:Number = (param1 >> 8 & 0xFF) / 255;
         var _loc5_:Number = (param1 & 0xFF) / 255;
         var _loc8_:Number = 0.48 * param2;
         var _loc7_:Number = _loc8_ * 0.05;
         var _loc6_:Number = 80 * param2;
         return new ColorMatrixFilter([1 - _loc8_ + _loc8_ * _loc3_,_loc7_ * _loc4_,_loc7_ * _loc5_,0,_loc3_ * _loc6_,_loc7_ * _loc3_,1 - _loc8_ + _loc8_ * _loc4_,_loc7_ * _loc5_,0,_loc4_ * _loc6_,_loc7_ * _loc3_,_loc7_ * _loc4_,1 - _loc8_ + _loc8_ * _loc5_,0,_loc5_ * _loc6_,0,0,0,1,0]);
      }
      
      private function onGlowTick(param1:TimerEvent) : void
      {
         if(UnknownVarFromBadgeImageWidget_Timer_1 == null)
         {
            return;
         }
         var _loc2_:Number = easeInOutCubic(UnknownVarFromBadgeImageWidget_Timer_1.currentCount,0,1,UnknownVarFromBadgeImageWidget_Timer_1.repeatCount);
         applyGlowStrength(_loc2_);
      }
      
      private function onGlowComplete(param1:TimerEvent) : void
      {
         clearGlow();
      }
      
      private function onPendingGlowTimeout(param1:TimerEvent) : void
      {
         cancelPendingGlow();
      }
      
      public function get etchingPoint() : Point
      {
         return new Point(0,1);
      }
      
      public function get wrapX() : Boolean
      {
         return false;
      }
      
      public function set wrapX(param1:Boolean) : void
      {
      }
      
      public function get wrapY() : Boolean
      {
         return false;
      }
      
      public function set wrapY(param1:Boolean) : void
      {
      }
      
      public function get flipX() : Boolean
      {
         return _bitmap.flipX;
      }
      
      public function set flipX(param1:Boolean) : void
      {
         _bitmap.flipX = param1;
         _bitmap.invalidate();
      }
      
      public function get flipY() : Boolean
      {
         return _bitmap.flipY;
      }
      
      public function set flipY(param1:Boolean) : void
      {
         _bitmap.flipY = param1;
         _bitmap.invalidate();
      }
      
      public function get rotation() : Number
      {
         return 0;
      }
      
      public function set rotation(param1:Number) : void
      {
      }
   }
}

