package com.sulake.habbo.toolbar
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.localization.ILocalization;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.events.ILinkEventTracker;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.UnknownICoreWindowComponents6;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.motion.Dispose;
   import com.sulake.core.window.motion.DropBounce;
   import com.sulake.core.window.motion.EaseOut;
   import com.sulake.core.window.motion.JumpBy;
   import com.sulake.core.window.motion.Motion;
   import com.sulake.core.window.motion.Motions;
   import com.sulake.core.window.motion.Queue;
   import com.sulake.core.window.motion.Wait;
   import com.sulake.core.window.utils.UnknownICoreWindowUtils4;
   import com.sulake.habbo.catalog.event.CatalogEvent;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.toolbar.memenu.MeMenuController;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import flash.display.BitmapData;
   import flash.events.IEventDispatcher;
   import flash.filters.GlowFilter;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class ToolbarView implements ILinkEventTracker
   {
      private static const ICON_BG_COLOR_OVER:uint = 7433577;
      
      private static const ICON_BG_COLOR_OUT:uint = 5723213;
      
      private static const ICON_MOUSE_OVER:String = "_hover";
      
      private static const ICON_MOUSE_OUT:String = "_normal";
      
      private static const COUNTER_MARGIN:int = 5;
      
      private static const ME_MENU_ICON_NAME:String = "icon_me_menu";
      
      private static const ICON_REGION_HEIGHT:int = 80;
      
      private static const ICON_LABEL_HEIGHT:int = 20;
      
      private static const WINDOW_BOTTOM_PADDING:int = 52;
      
      private static const DEFAULT_LOCATION:Point = new Point(3,3);
      
      private static const LANDING_VIEW_LOCATION:Point = new Point(3,3);
      
      private var _window:IWindowController_1;
      
      private var UnknownVarFromToolbarView_IEventDispatcher_1:IEventDispatcher;
      
      private var _disposed:Boolean;
      
      private var _toolbar:HabboToolbar;
      
      private var _assets:IAssetLibraryCollection;
      
      private var _windowManager:IHabboWindowManagerComponent;
      
      private var _unseenItemCounters:Map;
      
      private var UnknownVarFromToolbarView_IWindowController_1_1:IWindowController_1;
      
      private var _sessionDataManager:ISessionDataManager;
      
      private var UnknownVarFromToolbarView_Boolean_1:Boolean;
      
      private var UnknownVarFromToolbarView_BitmapData_1:BitmapData;
      
      private var UnknownVarFromToolbarView_BitmapData_2:BitmapData;
      
      private var _unseenMiniMailMessageCount:int;
      
      private var _unseenAchievementCount:int;
      
      private var _memenu:MeMenuController;
      
      public function ToolbarView(param1:HabboToolbar, param2:IHabboWindowManagerComponent, param3:IAssetLibraryCollection, param4:IEventDispatcher, param5:ISessionDataManager)
      {
         super();
         _toolbar = param1;
         _windowManager = param2;
         _assets = param3;
         UnknownVarFromToolbarView_IEventDispatcher_1 = param4;
         _sessionDataManager = param5;
         _memenu = new MeMenuController(_toolbar,this);
         _memenu.newUiEnabled = true;
         _unseenItemCounters = new Map();
         var _loc13_:XmlAsset = param3.getAssetByName("toolbar_view_xml") as XmlAsset;
         _window = param2.buildFromXML(_loc13_.content as XML,2) as IWindowController_1;
         if(_window == null)
         {
            throw new Error("Failed to construct window from XML!");
         }
         _window.position = DEFAULT_LOCATION;
         _window.addEventListener("WE_PARENT_RESIZED",onParentResized);
         var _loc9_:Array = [];
         _window.groupChildrenWithTag("TOGGLE",_loc9_,-1);
         for each(var _loc7_ in _loc9_)
         {
            if(_loc7_ && _loc7_ is IRegionWindow)
            {
               _loc7_.addEventListener("WME_CLICK",onIconClick);
               _loc7_.addEventListener("WME_OVER",onIconHoverMouseEvent);
               _loc7_.addEventListener("WME_OUT",onIconHoverMouseEvent);
            }
         }
         _loc9_ = [];
         _window.groupChildrenWithTag("ICON_BMP",_loc9_,-1);
         for each(var _loc11_ in _loc9_)
         {
            setIconHoverState(_loc11_,"_normal");
         }
         iconVisibility(HabboToolbarIconEnum.getIconName("HTIE_ICON_PROGRESSION"),false);
         iconVisibility(HabboToolbarIconEnum.getIconName("HTIE_ICON_MEMENU"),false);
         iconVisibility(HabboToolbarIconEnum.getIconName("HTIE_ICON_INVENTORY"),true);
         var _loc12_:Boolean = param1.getBoolean("games_icon_enabled");
         if(_loc12_)
         {
            iconVisibility(HabboToolbarIconEnum.getIconName("HTIE_ICON_GAMES"),true);
            iconVisibility(HabboToolbarIconEnum.getIconName("HTIE_ICON_ACHIEVEMENTS"),false);
         }
         else
         {
            iconVisibility(HabboToolbarIconEnum.getIconName("HTIE_ICON_GAMES"),false);
            iconVisibility(HabboToolbarIconEnum.getIconName("HTIE_ICON_ACHIEVEMENTS"),true);
         }
         var _loc10_:XmlAsset = param3.getAssetByName("new_items_label_xml") as XmlAsset;
         UnknownVarFromToolbarView_IWindowController_1_1 = param2.buildFromXML(_loc10_.content as XML,2) as IWindowController_1;
         if(UnknownVarFromToolbarView_IWindowController_1_1 == null)
         {
            throw new Error("Failed to construct toolbar label from XML!");
         }
         var _loc8_:IWindowController_1 = _window.findChildByName(HabboToolbarIconEnum.getIconName("HTIE_ICON_CATALOGUE")) as IWindowController_1;
         _loc8_.addChild(UnknownVarFromToolbarView_IWindowController_1_1);
         var _loc14_:ITextWindow = UnknownVarFromToolbarView_IWindowController_1_1.findChildByName("new_textfield") as ITextWindow;
         var _loc6_:ILocalization = param1.localization.getLocalizationRaw("toolbar.new_additions.notification");
         if(_loc6_ != null)
         {
            _loc14_.text = _loc6_.value;
         }
         UnknownVarFromToolbarView_IWindowController_1_1.visible = false;
         UnknownVarFromToolbarView_IWindowController_1_1.x = _loc8_.width - UnknownVarFromToolbarView_IWindowController_1_1.width - 5;
         UnknownVarFromToolbarView_IWindowController_1_1.y = 5;
         UnknownVarFromToolbarView_Boolean_1 = isNewItemsNotificationEnabled();
         checkSize();
         (_toolbar as Component).context.addLinkEventTracker(this);
      }
      
      private static function addShadow(param1:BitmapData, param2:Point, param3:uint) : BitmapData
      {
         var _loc4_:BitmapData = new BitmapData(param1.width,param1.height,true,0);
         _loc4_.fillRect(_loc4_.rect,param3);
         _loc4_.copyChannel(param1,param1.rect,new Point(0,0),8,8);
         var _loc5_:BitmapData = new BitmapData(param1.width + param2.x,param1.height + param2.y,true,0);
         _loc5_.copyPixels(_loc4_,_loc4_.rect,param2);
         _loc5_.copyPixels(param1,param1.rect,new Point(0,0),null,null,true);
         _loc4_.dispose();
         return _loc5_;
      }
      
      private function onPanicButton(param1:WindowMouseEvent) : void
      {
         _toolbar.toggleWindowVisibility("PANIC");
      }
      
      private function onParentResized(param1:WindowEvent) : void
      {
         checkSize();
      }
      
      private function checkSize() : void
      {
         if(!_window || !_windowManager)
         {
            return;
         }
         setLabelVisibility(true);
         if(shrinkListSpacing())
         {
            setLabelVisibility(false);
            shrinkListSpacing();
         }
         _window.invalidate();
         if(_memenu != null)
         {
            _memenu.reposition();
         }
      }
      
      private function setLabelVisibility(param1:Boolean) : void
      {
         var _loc4_:int = 0;
         var _loc2_:IWindowController_1 = null;
         var _loc6_:IWindowModel = null;
         var _loc5_:IItemListWindow = _window.findChildByName("toolbar_items") as IItemListWindow;
         var _loc3_:int = _loc5_.numListItems;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = _loc5_.getListItemAt(_loc4_) as IWindowController_1;
            if(_loc2_ != null)
            {
               _loc6_ = _loc2_.findChildByName("text");
               if(_loc6_ != null)
               {
                  _loc6_.visible = param1;
                  _loc2_.height = param1 ? 80 : 80 - 20;
               }
            }
            _loc4_++;
         }
      }
      
      private function shrinkListSpacing() : Boolean
      {
         var _loc1_:IItemListWindow = _window.findChildByName("toolbar_items") as IItemListWindow;
         _loc1_.spacing = 2;
         _loc1_.scrollV = 0;
         _loc1_.arrangeListItems();
         while(_window.bottom > _windowManager.getDesktop(2).height - 52)
         {
            if(_loc1_.spacing == -5)
            {
               return true;
            }
            _loc1_.spacing--;
         }
         return false;
      }
      
      public function dispose() : void
      {
         if(_memenu != null)
         {
            _memenu.dispose();
            _memenu = null;
         }
         if(UnknownVarFromToolbarView_BitmapData_1 != null)
         {
            UnknownVarFromToolbarView_BitmapData_1.dispose();
            UnknownVarFromToolbarView_BitmapData_1 = null;
         }
         if(UnknownVarFromToolbarView_BitmapData_2 != null)
         {
            UnknownVarFromToolbarView_BitmapData_2.dispose();
            UnknownVarFromToolbarView_BitmapData_2 = null;
         }
         if(_unseenItemCounters != null)
         {
            _unseenItemCounters.dispose();
            _unseenItemCounters = null;
         }
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
         if(UnknownVarFromToolbarView_IWindowController_1_1 != null)
         {
            UnknownVarFromToolbarView_IWindowController_1_1.dispose();
            UnknownVarFromToolbarView_IWindowController_1_1 = null;
         }
         if(_toolbar)
         {
            (_toolbar as Component).context.removeLinkEventTracker(this);
         }
         _toolbar = null;
         _windowManager = null;
         _assets = null;
         _disposed = true;
         if(UnknownVarFromToolbarView_IEventDispatcher_1)
         {
            UnknownVarFromToolbarView_IEventDispatcher_1 = null;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get window() : IWindowModel
      {
         return _window;
      }
      
      private function disableCatalogIcon() : void
      {
         var _loc1_:IWindowController_1 = _window.findChildByName(HabboToolbarIconEnum.getIconName("HTIE_ICON_CATALOGUE")) as IWindowController_1;
         _loc1_.blend = 0.5;
         _loc1_.disable();
      }
      
      public function onCatalogEvent(param1:CatalogEvent) : void
      {
         var _loc2_:IWindowController_1 = null;
         var _loc3_:String = null;
         switch(param1.type)
         {
            case "CATALOG_INITIALIZED":
               _loc2_ = _window.findChildByName(HabboToolbarIconEnum.getIconName("HTIE_ICON_CATALOGUE")) as IWindowController_1;
               _loc2_.blend = 1;
               _loc2_.enable();
               _loc3_ = _toolbar.getProperty("open.catalog.page");
               if(_loc3_.length > 0 && _toolbar.catalog)
               {
                  _toolbar.catalog.openCatalogPage("hc_membership");
                  _toolbar.setProperty("open.catalog.page","");
               }
               break;
            case "CATALOG_NOT_READY":
               disableCatalogIcon();
               break;
            case "CATALOG_NEW_ITEMS_SHOW":
               if(UnknownVarFromToolbarView_IWindowController_1_1 != null && UnknownVarFromToolbarView_Boolean_1)
               {
                  UnknownVarFromToolbarView_IWindowController_1_1.visible = true;
               }
               break;
            case "CATALOG_NEW_ITEMS_HIDE":
               if(UnknownVarFromToolbarView_IWindowController_1_1 != null)
               {
                  UnknownVarFromToolbarView_IWindowController_1_1.visible = false;
               }
         }
      }
      
      public function setToolbarState(param1:String) : void
      {
         var _loc3_:String = null;
         if(param1 == "HTE_STATE_HIDDEN")
         {
            _window.visible = false;
            return;
         }
         _window.visible = true;
         var _loc4_:Array = [];
         _window.groupChildrenWithTag("TOGGLE",_loc4_,-1);
         switch(param1)
         {
            case "HTE_STATE_GAME_CENTER_VIEW":
               _loc3_ = "VISIBLE_GAME_CENTER";
               _window.position = DEFAULT_LOCATION;
               break;
            case "HTE_STATE_HOTEL_VIEW":
               _loc3_ = "VISIBLE_HOTEL";
               _window.position = LANDING_VIEW_LOCATION;
               break;
            case "HTE_STATE_ROOM_VIEW":
               _loc3_ = "VISIBLE_ROOM";
               _window.position = DEFAULT_LOCATION;
         }
         for each(var _loc2_ in _loc4_)
         {
            if(_loc2_)
            {
               _loc2_.visible = _loc2_.tags.indexOf(_loc3_) >= 0;
               if(_loc2_.name == "QUESTS")
               {
                  _loc2_.visible &&= !_toolbar.isNewIdentity() || !_toolbar.getBoolean("new.identity.hide.quests");
                  _loc2_.visible &&= !_toolbar.getBoolean("toolbar.hide.quests");
               }
               if(_loc2_.name == "STORIES")
               {
                  _loc2_.visible &&= _toolbar.getBoolean("toolbar.stories.enabled");
               }
               if(_loc2_.name == "BUILDER")
               {
                  _loc2_.visible &&= _toolbar.getBoolean("builders.club.enabled");
               }
            }
         }
         checkSize();
      }
      
      public function iconVisibility(param1:String, param2:Boolean) : void
      {
         var _loc3_:IWindowController_1 = _window.findChildByName(param1) as IWindowController_1;
         if(_loc3_)
         {
            _loc3_.visible = param2;
         }
         checkSize();
      }
      
      private function onNaviHover(param1:WindowMouseEvent) : void
      {
         var _loc2_:Rectangle = null;
         if(_toolbar.navigator == null)
         {
            return;
         }
         switch(param1.type)
         {
            case "WME_OVER":
               _loc2_ = getIconLocation("HTIE_ICON_NAVIGATOR");
               _toolbar.navigator.showToolbarHover(new Point(_loc2_.right + 15,_loc2_.y));
               break;
            case "WME_OUT":
               _toolbar.navigator.hideToolbarHover(true);
         }
      }
      
      private function onIconHoverMouseEvent(param1:WindowMouseEvent) : void
      {
         var _loc2_:IWindowController_1 = param1.target as IWindowController_1;
         if(!_loc2_)
         {
            return;
         }
         var _loc3_:UnknownICoreWindowComponents6 = _loc2_.findChildByTag("ICON_BORDER") as UnknownICoreWindowComponents6;
         var _loc4_:UnknownICoreWindowUtils4 = _loc2_.findChildByTag("ICON_BMP") as UnknownICoreWindowUtils4;
         Logger.log(param1);
         switch(param1.type)
         {
            case "WME_OVER":
               setIconHoverState(_loc4_,"_hover");
               setIconBgHoverState(_loc3_,"_hover");
               if(param1.target.name == "NAVIGATOR")
               {
                  onNaviHover(param1);
               }
               break;
            case "WME_OUT":
               setIconHoverState(_loc4_,"_normal");
               setIconBgHoverState(_loc3_,"_normal");
               if(param1.target.name == "NAVIGATOR")
               {
                  onNaviHover(param1);
               }
         }
      }
      
      private function setIconHoverState(param1:UnknownICoreWindowUtils4, param2:String) : void
      {
         var _loc3_:IStaticBitmapWrapperWindow = null;
         var _loc4_:IBitmapWrapperController = null;
         if(param1 is IStaticBitmapWrapperWindow)
         {
            _loc3_ = param1 as IStaticBitmapWrapperWindow;
            _loc3_.assetUri = _loc3_.name + param2;
         }
         else if(param1 is IBitmapWrapperController)
         {
            _loc4_ = param1 as IBitmapWrapperController;
            if(_loc4_.name == "icon_me_menu")
            {
               _loc4_.bitmap = param2 == "_normal" ? UnknownVarFromToolbarView_BitmapData_1 : UnknownVarFromToolbarView_BitmapData_2;
            }
         }
      }
      
      private function setIconBgHoverState(param1:IWindowController_1, param2:String) : void
      {
         if(!param1)
         {
            return;
         }
         if(param2 == "_hover")
         {
            param1.color = 7433577;
         }
         else
         {
            param1.color = 5723213;
         }
      }
      
      private function onIconClick(param1:WindowMouseEvent) : void
      {
         var _loc2_:String = IWindowModel(param1.target).name;
         _toolbar.toggleWindowVisibility(_loc2_);
      }
      
      public function setIconBitmap(param1:String, param2:BitmapData) : void
      {
         var _loc3_:String = null;
         if(!param2)
         {
            return;
         }
         var _loc5_:* = param1;
         if("HTIE_ICON_MEMENU" === _loc5_)
         {
            _loc3_ = "icon_me_menu";
            setMeMenuIconBitmaps(param2);
         }
         var _loc4_:UnknownICoreWindowUtils4 = _window.findChildByName(_loc3_) as UnknownICoreWindowUtils4;
         if(_loc4_ != null)
         {
            setIconHoverState(_loc4_,"_normal");
         }
      }
      
      public function getIconLocation(param1:String) : Rectangle
      {
         var _loc3_:IWindowModel = null;
         var _loc2_:Rectangle = null;
         switch(param1)
         {
            case "HTIE_ICON_NAVIGATOR":
               _loc3_ = _window.findChildByName(HabboToolbarIconEnum.getIconName("HTIE_ICON_NAVIGATOR"));
               break;
            case "HTIE_ICON_PROGRESSION":
               _loc3_ = _window.findChildByName(HabboToolbarIconEnum.getIconName("HTIE_ICON_PROGRESSION"));
               break;
            case "HTIE_ICON_GAMES":
               _loc3_ = _window.findChildByName(HabboToolbarIconEnum.getIconName("HTIE_ICON_GAMES"));
         }
         if(_loc3_ != null && _loc3_.visible)
         {
            _loc2_ = new Rectangle();
            _loc3_.getGlobalRectangle(_loc2_);
            return _loc2_;
         }
         return null;
      }
      
      private function setMeMenuIconBitmaps(param1:BitmapData) : void
      {
         if(UnknownVarFromToolbarView_BitmapData_1 != null)
         {
            UnknownVarFromToolbarView_BitmapData_1.dispose();
         }
         if(UnknownVarFromToolbarView_BitmapData_2 != null)
         {
            UnknownVarFromToolbarView_BitmapData_2.dispose();
         }
         UnknownVarFromToolbarView_BitmapData_1 = addShadow(param1,new Point(2,3),4280426782);
         UnknownVarFromToolbarView_BitmapData_2 = addShadow(param1,new Point(4,5),4281150249);
         param1.dispose();
      }
      
      public function setUnseenItemCount(param1:String, param2:int) : void
      {
         var _loc3_:IWindowController_1 = getUnseenItemCounter(param1);
         if(!_loc3_)
         {
            return;
         }
         if(param2 < 0)
         {
            _loc3_.visible = true;
            _loc3_.findChildByName("count").caption = " ";
         }
         else if(param2 > 0)
         {
            _loc3_.visible = true;
            _loc3_.findChildByName("count").caption = param2.toString();
         }
         else
         {
            _loc3_.visible = false;
         }
      }
      
      public function getUnseenItemCounter(param1:String) : IWindowController_1
      {
         var _loc2_:IWindowController_1 = null;
         var _loc4_:String = HabboToolbarIconEnum.getIconName(param1);
         if(!_loc4_)
         {
            Logger.log("[Toolbar] Unknown icon type for unseen item counter for iconId: " + param1);
         }
         var _loc3_:IWindowController_1 = _unseenItemCounters.getValue(param1) as IWindowController_1;
         if(!_loc3_)
         {
            _loc3_ = _windowManager.createUnseenItemCounter();
            _loc2_ = _window.findChildByName(_loc4_) as IWindowController_1;
            if(_loc2_)
            {
               _loc2_.addChild(_loc3_);
               _loc3_.x = _loc2_.width - _loc3_.width - 5;
               _loc3_.y = 5;
               _unseenItemCounters.add(param1,_loc3_);
            }
         }
         return _loc3_;
      }
      
      public function isNewItemsNotificationEnabled() : Boolean
      {
         return _toolbar.getBoolean("toolbar.new_additions.notification.enabled");
      }
      
      public function animateToIcon(param1:String, param2:BitmapData, param3:int, param4:int) : Motion
      {
         var _loc14_:IWindowModel = null;
         var _loc11_:int = 20;
         var _loc16_:int = !!param2 ? param2.width : _loc11_;
         var _loc19_:int = !!param2 ? param2.height : _loc11_;
         var _loc18_:IBitmapWrapperController = _windowManager.create("ToolBarTransition",21,0,0,new Rectangle(param3,param4,_loc16_,_loc19_)) as IBitmapWrapperController;
         if(param2)
         {
            _loc18_.bitmap = param2;
            _loc18_.disposesBitmap = true;
            _loc18_.filters = [new GlowFilter(16777215,1,2,2,255,1,false,false)];
         }
         _windowManager.getDesktop(2).addChild(_loc18_);
         var _loc7_:String = null;
         switch(param1)
         {
            case "HTIE_ICON_CATALOGUE":
               _loc7_ = "icons_toolbar_catalogue";
               break;
            case "HTIE_ICON_INVENTORY":
               _loc7_ = "icons_toolbar_inventory";
               break;
            case "HTIE_ICON_MEMENU":
               _loc7_ = "icons_toolbar_me_menu";
               break;
            case "HTIE_ICON_NAVIGATOR":
               _loc7_ = "icons_toolbar_navigator";
               break;
            case "HTIE_ICON_PROGRESSION":
               _loc7_ = "icons_toolbar_progression";
               break;
            case "HTIE_ICON_GAMES":
               _loc7_ = "icons_toolbar_games";
               break;
            case "HTIE_ICON_STORIES":
               _loc7_ = "icons_toolbar_stories";
               break;
            case "HTIE_ICON_RECEPTION":
               _loc7_ = "icons_toolbar_reception";
         }
         if(_loc7_ != null)
         {
            _loc14_ = _window.findChildByName(_loc7_);
         }
         if(!_loc14_)
         {
            _loc18_.dispose();
            return null;
         }
         var _loc12_:Rectangle = new Rectangle();
         _loc18_.getGlobalRectangle(_loc12_);
         var _loc10_:Rectangle = new Rectangle();
         _loc14_.getGlobalRectangle(_loc10_);
         var _loc13_:int = _loc12_.x - _loc10_.x;
         var _loc15_:int = _loc12_.y - _loc10_.y;
         var _loc5_:Number = Math.sqrt(_loc13_ * _loc13_ + _loc15_ * _loc15_);
         var _loc8_:int = 500 - Math.abs(1 / _loc5_ * 100 * 500 * 0.5);
         var _loc9_:int = 20;
         var _loc17_:String = "ToolBarBouncing[ " + _loc7_ + " ]";
         if(!Motions.getMotionByTag(_loc17_))
         {
            Motions.runMotion(new Queue(new Wait(_loc8_ + 8),new DropBounce(_loc14_,400,12))).tag = _loc17_;
         }
         var _loc6_:Motion = new Queue(new EaseOut(new JumpBy(_loc18_,_loc8_,_loc10_.x - _loc12_.x + _loc9_,_loc10_.y - _loc12_.y,100,1),1),new Dispose(_loc18_));
         return Motions.runMotion(_loc6_);
      }
      
      public function set onDuty(param1:Boolean) : void
      {
         _window.findChildByName("guide_icon").visible = param1;
      }
      
      public function get unseenAchievementCount() : int
      {
         return _unseenAchievementCount;
      }
      
      public function set unseenAchievementCount(param1:int) : void
      {
         _unseenAchievementCount = param1;
      }
      
      public function get unseenMiniMailMessageCount() : int
      {
         return _unseenMiniMailMessageCount;
      }
      
      public function set unseenMiniMailMessageCount(param1:int) : void
      {
         _unseenMiniMailMessageCount = param1;
      }
      
      public function get memenu() : MeMenuController
      {
         return _memenu;
      }
      
      public function get linkPattern() : String
      {
         return "toolbar/";
      }
      
      public function linkReceived(param1:String) : void
      {
         var _loc2_:Array = param1.split("/");
         if(_loc2_.length < 2)
         {
            return;
         }
         var _loc3_:* = _loc2_[1];
         if("memenu" !== _loc3_)
         {
            Logger.log("Toolbar unknown link-type received: " + _loc2_[1]);
         }
         else
         {
            memenu.toggleVisibility();
         }
      }
   }
}

