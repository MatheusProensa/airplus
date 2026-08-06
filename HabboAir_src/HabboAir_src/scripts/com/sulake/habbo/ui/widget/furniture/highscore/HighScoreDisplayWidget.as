package com.sulake.habbo.ui.widget.furniture.highscore
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IBubbleController;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.room.object.data.HighScoreData;
   import com.sulake.habbo.room.object.data.HighScoreStuffData;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.handler.HighScoreFurniWidgetHandler;
   import com.sulake.habbo.ui.widget.RoomWidgetBase;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class HighScoreDisplayWidget extends RoomWidgetBase
   {
      public static const INVALID_ID:int = -1;
      
      private static const RELATIVE_OFFSET_X:int = -138;
      
      private static const RELATIVE_OFFSET_Y:int = -400;
      
      private static const SCORETYPE_ONE_PER_TEAM:int = 0;
      
      private static const SCORETYPE_AGGREGATED_WINS:int = 1;
      
      private static const SCORETYPE_ALWAYS_NEW_SCORE:int = 2;
      
      private static const CLEARTYPE_NEVER:int = 0;
      
      private static const CLEARTYPE_DAILY:int = 1;
      
      private static const CLEARTYPE_WEEKLY:int = 2;
      
      private static const CLEARTYPE_MONTHLY:int = 3;
      
      private static const SCORETYPE_LOCALIZATION_KEY_POSTFIX:Array = ["perteam","mostwins","classic","fastesttime","longesttime"];
      
      private static const CLEARTYPE_LOCALIZATION_KEY_POSTFIX:Array = ["alltime","daily","weekly","monthly"];
      
      private var _mainWindow:IWindowController_1;
      
      private var _bubble:IBubbleController;
      
      private var UnknownVarFromHighScoreDisplayWidget_IWindowController_1_1:IWindowController_1;
      
      private var _roomId:int = -1;
      
      private var _roomObjId:int = -1;
      
      private var UnknownVarFromHighScoreDisplayWidget_Point_1:Point = new Point(0,0);
      
      public function HighScoreDisplayWidget(param1:IRoomWidgetHandler, param2:IHabboWindowManagerComponent, param3:IAssetLibraryCollection = null, param4:IHabboLocalizationManager = null)
      {
         super(param1,param2,param3,param4);
         HighScoreFurniWidgetHandler(param1).widget = this;
         _mainWindow = IWindowController_1(param2.createWindow("room_widget_highscore_background_container","",4,0,0,new Rectangle(0,0,10,10)));
         resizeRootContainerToDesktop();
         _mainWindow.addEventListener("WE_PARENT_RESIZED",resizeRootContainerToDesktop);
      }
      
      private static function scoreToTime(param1:int, param2:int) : String
      {
         var _loc3_:int = 0;
         var _loc6_:String = null;
         var _loc5_:Array = [60,60,24];
         if(param2 < 1 || param2 > _loc5_.length)
         {
            return param1 + "";
         }
         var _loc4_:String = "";
         _loc3_ = 0;
         while(_loc3_ < param2)
         {
            if(_loc3_ == param2 - 1)
            {
               _loc6_ = param1 + "";
            }
            else
            {
               _loc6_ = "" + param1 % _loc5_[_loc3_];
               param1 /= _loc5_[_loc3_];
            }
            if(_loc6_.length < 2 && _loc3_ < 2)
            {
               _loc6_ = "0" + _loc6_;
            }
            _loc4_ = _loc6_ + ":" + _loc4_;
            _loc3_++;
         }
         return _loc4_.substring(0,_loc4_.length - 1);
      }
      
      private function resizeRootContainerToDesktop(param1:WindowEvent = null) : void
      {
         _mainWindow.width = _mainWindow.desktop.width;
         _mainWindow.height = _mainWindow.desktop.height;
      }
      
      override public function get mainWindow() : IWindowModel
      {
         return _mainWindow;
      }
      
      override public function dispose() : void
      {
         if(_bubble != null)
         {
            destroyWindow();
         }
         _mainWindow.removeEventListener("WE_PARENT_RESIZED",resizeRootContainerToDesktop);
         _mainWindow.dispose();
         super.dispose();
      }
      
      public function open(param1:int, param2:int, param3:HighScoreStuffData) : void
      {
         var _loc4_:String = null;
         var _loc11_:String = null;
         var _loc7_:IWindowController_1 = null;
         var _loc6_:String = null;
         if(_bubble != null)
         {
            destroyWindow();
         }
         var _loc8_:* = false;
         if(param3.clearType != -1 && param3.scoreType != -1)
         {
            _loc8_ = SCORETYPE_LOCALIZATION_KEY_POSTFIX[param3.scoreType].indexOf("time") >= 0;
            _loc4_ = HighScoreFurniWidgetHandler(_widgetHandler).container.localization.getLocalization("high.score.display.cleartype." + CLEARTYPE_LOCALIZATION_KEY_POSTFIX[param3.clearType]);
            _loc11_ = HighScoreFurniWidgetHandler(_widgetHandler).container.localization.getLocalization("high.score.display.scoretype." + SCORETYPE_LOCALIZATION_KEY_POSTFIX[param3.scoreType]);
            HighScoreFurniWidgetHandler(_widgetHandler).container.localization.registerParameter("high.score.display.caption","cleartype",_loc4_);
            HighScoreFurniWidgetHandler(_widgetHandler).container.localization.registerParameter("high.score.display.caption","scoretype",_loc11_);
         }
         _roomId = param2;
         _roomObjId = param1;
         createWindow();
         if(!UnknownVarFromHighScoreDisplayWidget_IWindowController_1_1)
         {
            Logger.log("ERROR: \'entry_template\' could not found from high score display\'s window XML");
            return;
         }
         var _loc9_:ITextWindow = ITextWindow(_bubble.findChildByName("score_header"));
         _loc9_.caption = HighScoreFurniWidgetHandler(_widgetHandler).container.localization.getLocalization(_loc8_ ? "high.score.display.time.header" : "high.score.display.score.header");
         _loc9_.invalidate();
         var _loc10_:IItemListWindow = IItemListWindow(_bubble.findChildByName("entries"));
         for each(var _loc5_ in param3.entries)
         {
            _loc7_ = IWindowController_1(UnknownVarFromHighScoreDisplayWidget_IWindowController_1_1.clone());
            _loc7_.getChildByName("usernames").caption = getUserNameList(_loc5_.users);
            _loc6_ = _loc8_ ? (_loc5_.score >= 3600 ? scoreToTime(_loc5_.score,3) : scoreToTime(_loc5_.score,2)) : _loc5_.score.toString();
            _loc7_.getChildByName("score").caption = _loc6_;
            _loc10_.addListItem(_loc7_);
         }
         _loc10_.invalidate();
      }
      
      private function getUserNameList(param1:Array) : String
      {
         var _loc2_:String = "";
         for each(var _loc3_ in param1)
         {
            _loc2_ = _loc2_ + _loc3_ + ", ";
         }
         return _loc2_.substr(0,_loc2_.length - 2);
      }
      
      public function setRelativePositionToRoomObjectAt(param1:int, param2:int) : void
      {
         if(!_bubble)
         {
            return;
         }
         _bubble.x = param1 + -138;
         _bubble.y = param2 + -400;
      }
      
      private function createWindow() : void
      {
         var _loc1_:IBubbleController = IBubbleController(windowManager.buildFromXML(XML(assets.getAssetByName("high_score_display_xml").content)));
         UnknownVarFromHighScoreDisplayWidget_IWindowController_1_1 = IWindowController_1(_loc1_.findChildByName("entry_template"));
         IItemListWindow(_loc1_.findChildByName("entries")).removeListItem(UnknownVarFromHighScoreDisplayWidget_IWindowController_1_1);
         _bubble = _loc1_;
         _bubble.x = UnknownVarFromHighScoreDisplayWidget_Point_1.x;
         _bubble.y = UnknownVarFromHighScoreDisplayWidget_Point_1.y;
         _mainWindow.addChild(_loc1_);
      }
      
      private function destroyWindow() : void
      {
         _mainWindow.removeChild(_bubble);
         UnknownVarFromHighScoreDisplayWidget_Point_1.x = _bubble.x;
         UnknownVarFromHighScoreDisplayWidget_Point_1.y = _bubble.y;
         _bubble.dispose();
         _bubble = null;
         _roomId = -1;
         _roomObjId = -1;
      }
      
      public function get isOpen() : Boolean
      {
         return _bubble != null && Boolean(_bubble.visible);
      }
      
      public function get roomId() : int
      {
         return _roomId;
      }
      
      public function get roomObjId() : int
      {
         return _roomObjId;
      }
      
      public function close() : void
      {
         destroyWindow();
      }
   }
}

