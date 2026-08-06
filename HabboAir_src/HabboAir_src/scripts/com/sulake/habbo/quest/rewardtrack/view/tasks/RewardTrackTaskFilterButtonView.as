package com.sulake.habbo.quest.rewardtrack.view.tasks
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.ShapeController;
   import com.sulake.core.window.components.UnknownICoreWindowComponents4;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.quest.rewardtrack.view.theme.RewardTrackTheme;
   
   public class RewardTrackTaskFilterButtonView implements IComponentInterfaceQueue
   {
      private static const UnknownConstFromRewardTrackTaskFilterButtonView_Uint_1:uint = 4294967295;
      
      private static const NOT_SELECTED_TEXT_COLOR:uint = 4282664004;
      
      private var _window:IRegionWindow;
      
      private var UnknownVarFromRewardTrackTaskFilterButtonView_Int_1:int;
      
      private var UnknownVarFromRewardTrackTaskFilterButtonView_RewardTrackTaskListView_1:RewardTrackTaskListView;
      
      private var _theme:RewardTrackTheme;
      
      private var _defaultNotSelectedColor:uint;
      
      private var _defaultNotSelectedBorderColor:uint;
      
      private var _active:Boolean;
      
      private var UnknownVarFromRewardTrackTaskFilterButtonView_Boolean_1:Boolean;
      
      private var _disposed:Boolean;
      
      public function RewardTrackTaskFilterButtonView(param1:IRegionWindow, param2:int, param3:String, param4:RewardTrackTaskListView, param5:RewardTrackTheme)
      {
         super();
         _window = param1;
         UnknownVarFromRewardTrackTaskFilterButtonView_Int_1 = param2;
         UnknownVarFromRewardTrackTaskFilterButtonView_RewardTrackTaskListView_1 = param4;
         _theme = param5;
         _theme.applyTo(_window);
         _defaultNotSelectedColor = notSelectedShape.color;
         _defaultNotSelectedBorderColor = notSelectedShape.strokeColor;
         selectedView.setParamFlag(1,false);
         selectedView.interactiveCursorDisabled = true;
         buttonText.text = "${" + param3 + "}";
         _window.addEventListener("WME_CLICK",onClick);
         _window.addEventListener("WME_OVER",onMouseOver);
         _window.addEventListener("WME_OUT",onMouseOut);
      }
      
      public function setActive(param1:Boolean) : void
      {
         _active = param1;
         refreshState();
      }
      
      private function onClick(param1:WindowMouseEvent) : void
      {
         UnknownVarFromRewardTrackTaskFilterButtonView_RewardTrackTaskListView_1.setFilter(UnknownVarFromRewardTrackTaskFilterButtonView_Int_1);
      }
      
      private function onMouseOver(param1:WindowMouseEvent) : void
      {
         UnknownVarFromRewardTrackTaskFilterButtonView_Boolean_1 = true;
         refreshState();
      }
      
      private function onMouseOut(param1:WindowMouseEvent) : void
      {
         UnknownVarFromRewardTrackTaskFilterButtonView_Boolean_1 = false;
         refreshState();
      }
      
      private function refreshState() : void
      {
         selectedView.visible = _active;
         notSelectedShape.visible = !_active;
         notSelectedShape.color = !_active && UnknownVarFromRewardTrackTaskFilterButtonView_Boolean_1 ? _theme.lightColor : _defaultNotSelectedColor;
         notSelectedShape.strokeColor = !_active && UnknownVarFromRewardTrackTaskFilterButtonView_Boolean_1 ? _theme.darkColor : _defaultNotSelectedBorderColor;
         buttonText.textColor = _active ? 4294967295 : 4282664004;
         _window.interactiveCursorDisabled = _active;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         _window.removeEventListener("WME_CLICK",onClick);
         _window.removeEventListener("WME_OVER",onMouseOver);
         _window.removeEventListener("WME_OUT",onMouseOut);
         _window.dispose();
         _window = null;
         UnknownVarFromRewardTrackTaskFilterButtonView_RewardTrackTaskListView_1 = null;
         _theme = null;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get window() : IWindowController_1
      {
         return _window;
      }
      
      private function get selectedView() : UnknownICoreWindowComponents4
      {
         return _window.findChildByName("selected_view") as UnknownICoreWindowComponents4;
      }
      
      private function get notSelectedShape() : ShapeController
      {
         return _window.findChildByName("notselected_shape") as ShapeController;
      }
      
      private function get buttonText() : ITextWindow
      {
         return _window.findChildByName("button_text") as ITextWindow;
      }
   }
}

