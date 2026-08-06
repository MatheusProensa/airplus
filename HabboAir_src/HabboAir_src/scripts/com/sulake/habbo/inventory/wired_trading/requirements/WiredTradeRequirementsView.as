package com.sulake.habbo.inventory.wired_trading.requirements
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.components.IBubbleController;
   import com.sulake.core.window.components.IHTMLTextController;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.IWidgetWindowController;
   import com.sulake.core.window.components.UnknownICoreWindowComponents6;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.trade.requirements.TradeRequirement;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.trade.requirements.rules.TradeRequirementRule;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.trade.requirements.rules.UnknownHabboCommunicationMessagesParserUserdefinedroomeventsWiredtradingTradeRequirementsRules1;
   import com.sulake.habbo.inventory.wired_trading.WiredTradingModel;
   import com.sulake.habbo.inventory.wired_trading.requirements.offerings.OfferingRequirementsView;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class WiredTradeRequirementsView implements IComponentInterfaceQueue
   {
      private static var MIN_BORDER_HEIGHT:int = 80;
      
      private static var BORDER_TOP_BOTTOM_OFFSET:int = 18;
      
      private static var MINIMALIZED_BORDER_WIDTH:int = 122;
      
      private static var NORMAL_BORDER_WIDTH:int = 180;
      
      private static var UnknownVarFromWiredTradeRequirementsView_Vector_1:Vector.<OfferingRequirementsView> = new Vector.<OfferingRequirementsView>(0);
      
      private var _disposed:Boolean;
      
      private var UnknownVarFromWiredTradeRequirementsView_WiredTradeRequirementsModel_1:WiredTradeRequirementsModel;
      
      private var _bubble:IBubbleController;
      
      private var _offeringsTemplate:IWindowController_1;
      
      private var UnknownVarFromWiredTradeRequirementsView_TradeRequirement_1:TradeRequirement;
      
      private var UnknownVarFromWiredTradeRequirementsView_OfferingRequirementsView_1:OfferingRequirementsView;
      
      private var UnknownVarFromWiredTradeRequirementsView_OfferingRequirementsView_2:OfferingRequirementsView;
      
      private var _offeringBorderMargins:int;
      
      private var _transitionTimer:Timer;
      
      public function WiredTradeRequirementsView(param1:WiredTradeRequirementsModel)
      {
         super();
         UnknownVarFromWiredTradeRequirementsView_WiredTradeRequirementsModel_1 = param1;
         claimRequirementsBubble();
         requirementsButton.addEventListener("WME_CLICK",onRequirementsClicked);
         _offeringsTemplate = youGiveContainer.getChildByName("offering_requirements_template") as IWindowController_1;
         initializeStretchingWithParent(_offeringsTemplate,false);
         _offeringBorderMargins = _offeringsTemplate.height - _offeringsTemplate.findChildByName("requirements_definition").height;
         (_offeringsTemplate.parent as IWindowController_1).removeChild(_offeringsTemplate);
      }
      
      private static function claimRequirementView(param1:IWindowController_1) : OfferingRequirementsView
      {
         var _loc2_:OfferingRequirementsView = null;
         if(UnknownVarFromWiredTradeRequirementsView_Vector_1.length > 0)
         {
            _loc2_ = UnknownVarFromWiredTradeRequirementsView_Vector_1.pop();
         }
         else
         {
            _loc2_ = new OfferingRequirementsView(param1);
         }
         return _loc2_;
      }
      
      private static function releaseRequirementView(param1:OfferingRequirementsView) : void
      {
         param1.recycle();
         UnknownVarFromWiredTradeRequirementsView_Vector_1.push(param1);
      }
      
      private static function easeInOutCubic(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         var _loc5_:Number = param1 / param4;
         var _loc6_:Number = -(_loc5_ * 1.75 - 0.7) * (_loc5_ * 1.75 - 0.7) + 1;
         return param2 + param3 * _loc6_;
      }
      
      private function claimRequirementsBubble() : void
      {
         var _loc1_:IWindowController_1 = tradingModel.getWindowContainer();
         _bubble = _loc1_.findChildByName("trade_requirements_bubble") as IBubbleController;
         _bubble.visible = false;
         recenter();
      }
      
      private function onRequirementsClicked(param1:WindowMouseEvent) : void
      {
         toggleVisibility();
      }
      
      private function toggleVisibility() : void
      {
         _bubble.visible = !_bubble.visible;
      }
      
      private function get requirementsButton() : IRegionWindow
      {
         return UnknownVarFromWiredTradeRequirementsView_WiredTradeRequirementsModel_1.tradingModel.tradingView.requirementsButton;
      }
      
      private function recenter() : void
      {
         var _loc1_:IRegionWindow = requirementsButton;
         _bubble.x = _loc1_.x + _loc1_.width + 4;
         _bubble.y = _loc1_.y + _loc1_.height / 2 - _bubble.height / 2;
      }
      
      private function clear() : void
      {
         if(UnknownVarFromWiredTradeRequirementsView_OfferingRequirementsView_1 != null)
         {
            youGiveContainer.removeChild(UnknownVarFromWiredTradeRequirementsView_OfferingRequirementsView_1.window);
            releaseRequirementView(UnknownVarFromWiredTradeRequirementsView_OfferingRequirementsView_1);
            UnknownVarFromWiredTradeRequirementsView_OfferingRequirementsView_1 = null;
         }
         if(UnknownVarFromWiredTradeRequirementsView_OfferingRequirementsView_2 != null)
         {
            youGetContainer.removeChild(UnknownVarFromWiredTradeRequirementsView_OfferingRequirementsView_2.window);
            releaseRequirementView(UnknownVarFromWiredTradeRequirementsView_OfferingRequirementsView_2);
            UnknownVarFromWiredTradeRequirementsView_OfferingRequirementsView_2 = null;
         }
         UnknownVarFromWiredTradeRequirementsView_TradeRequirement_1 = null;
      }
      
      public function requirementsUpdated(param1:TradeRequirement, param2:Boolean) : void
      {
         var _loc5_:* = undefined;
         clear();
         UnknownVarFromWiredTradeRequirementsView_TradeRequirement_1 = param1;
         var _loc4_:Boolean = param1.isPaymentOnly();
         var _loc3_:String = UnknownVarFromWiredTradeRequirementsView_WiredTradeRequirementsModel_1.tradingModel.tradeTypeLocalization;
         bubbleTitle.text = localization.getLocalizationWithParams("inventory.wired_trading.requirements.title","","type",_loc3_);
         var _loc6_:Boolean = !_loc4_ || UnknownVarFromWiredTradeRequirementsView_TradeRequirement_1.youGetText != null && UnknownVarFromWiredTradeRequirementsView_TradeRequirement_1.youGetText.length > 0;
         offeringContainersSeparator.visible = _loc6_;
         youGetContainer.visible = _loc6_;
         UnknownVarFromWiredTradeRequirementsView_OfferingRequirementsView_1 = claimRequirementView(_offeringsTemplate);
         UnknownVarFromWiredTradeRequirementsView_OfferingRequirementsView_1.initialize(UnknownVarFromWiredTradeRequirementsView_WiredTradeRequirementsModel_1,param1.type,UnknownVarFromWiredTradeRequirementsView_TradeRequirement_1.rules?.youGiveRule,null,OfferingRequirementsView.TYPE_GIVE);
         youGiveContainer.addChild(UnknownVarFromWiredTradeRequirementsView_OfferingRequirementsView_1.window);
         initializeStretchingWithParent(UnknownVarFromWiredTradeRequirementsView_OfferingRequirementsView_1.window);
         if(_loc6_)
         {
            _loc5_ = new Vector.<TradeRequirementRule>();
            if(UnknownVarFromWiredTradeRequirementsView_TradeRequirement_1.rules != null && UnknownVarFromWiredTradeRequirementsView_TradeRequirement_1.rules.youGetRule != null)
            {
               _loc5_.push(UnknownVarFromWiredTradeRequirementsView_TradeRequirement_1.rules.youGetRule);
            }
            UnknownVarFromWiredTradeRequirementsView_OfferingRequirementsView_2 = claimRequirementView(_offeringsTemplate);
            UnknownVarFromWiredTradeRequirementsView_OfferingRequirementsView_2.initialize(UnknownVarFromWiredTradeRequirementsView_WiredTradeRequirementsModel_1,param1.type,_loc5_,UnknownVarFromWiredTradeRequirementsView_TradeRequirement_1.youGetText,OfferingRequirementsView.TYPE_RECEIVE);
            youGetContainer.addChild(UnknownVarFromWiredTradeRequirementsView_OfferingRequirementsView_2.window);
            initializeStretchingWithParent(UnknownVarFromWiredTradeRequirementsView_OfferingRequirementsView_2.window);
         }
         requirementsStateUpdated();
         disclaimerTextHtml.visible = _loc4_ && _loc6_;
         if(disclaimerTextHtml.visible)
         {
            disclaimerTextHtml.text = localization.getLocalizationWithParams("inventory.wired_trading.requirements.receive_text_disclaimer","","you_get_name",localization.getLocalization("inventory.wired_trading.requirements.receiving"));
            resizeHtml(disclaimerTextHtml);
         }
         if(param1.isPaymentOnly())
         {
            tradingModel.inventory.windowManager.LilithCustomsInstance.OnWiredTradePaymentOnly(youGiveContainer,youGetContainer,disclaimerTextHtml,UnknownVarFromWiredTradeRequirementsView_OfferingRequirementsView_1,UnknownVarFromWiredTradeRequirementsView_OfferingRequirementsView_2);
         }
         _bubble.visible = param2;
      }
      
      private function resizeRequirementContainers() : void
      {
         var _loc1_:int = NORMAL_BORDER_WIDTH;
         if(youGiveContainer.visible && Boolean(youGetContainer.visible) && UnknownVarFromWiredTradeRequirementsView_OfferingRequirementsView_1 != null && UnknownVarFromWiredTradeRequirementsView_OfferingRequirementsView_2 != null && UnknownVarFromWiredTradeRequirementsView_OfferingRequirementsView_1.canMinimalizeWidth && UnknownVarFromWiredTradeRequirementsView_OfferingRequirementsView_2.canMinimalizeWidth)
         {
            _loc1_ = MINIMALIZED_BORDER_WIDTH;
         }
         youGiveContainer.width = _loc1_;
         youGetContainer.width = _loc1_;
         var _loc2_:int = UnknownVarFromWiredTradeRequirementsView_OfferingRequirementsView_1.minBorderHeight;
         if(UnknownVarFromWiredTradeRequirementsView_OfferingRequirementsView_2 != null && UnknownVarFromWiredTradeRequirementsView_OfferingRequirementsView_2.minBorderHeight > _loc2_)
         {
            _loc2_ = UnknownVarFromWiredTradeRequirementsView_OfferingRequirementsView_2.minBorderHeight;
         }
         _loc2_ += 2 * BORDER_TOP_BOTTOM_OFFSET;
         if(_loc2_ < MIN_BORDER_HEIGHT)
         {
            _loc2_ = MIN_BORDER_HEIGHT;
         }
         offeringContainersSeparator.height = _loc2_;
         _loc2_ += _offeringBorderMargins;
         youGiveContainer.height = _loc2_;
         youGetContainer.height = _loc2_;
         UnknownVarFromWiredTradeRequirementsView_OfferingRequirementsView_1.centerActiveElement();
         if(UnknownVarFromWiredTradeRequirementsView_OfferingRequirementsView_2 != null)
         {
            UnknownVarFromWiredTradeRequirementsView_OfferingRequirementsView_2.centerActiveElement();
         }
      }
      
      public function requirementsStateUpdated() : void
      {
         var _loc3_:String = null;
         if(UnknownVarFromWiredTradeRequirementsView_TradeRequirement_1 == null)
         {
            return;
         }
         var _loc2_:Boolean = tradingModel.canAccept;
         var _loc1_:int = tradingModel.extra;
         if(UnknownVarFromWiredTradeRequirementsView_TradeRequirement_1.rules != null && UnknownVarFromWiredTradeRequirementsView_TradeRequirement_1.rules.type == UnknownHabboCommunicationMessagesParserUserdefinedroomeventsWiredtradingTradeRequirementsRules1.UnknownVarFromUnknownHabboCommunicationMessagesParserUserdefinedroomeventsWiredtradingTradeRequirementsRules1_Int_2)
         {
            requirementsMetHtml.text = localization.getLocalizationWithParams("inventory.wired_trading.requirements.indicator.multi","","times",UnknownVarFromWiredTradeRequirementsView_TradeRequirement_1.rules.multiplier,"amount",_loc1_);
         }
         else if(_loc2_)
         {
            if(UnknownVarFromWiredTradeRequirementsView_TradeRequirement_1.rules != null && UnknownVarFromWiredTradeRequirementsView_TradeRequirement_1.rules.type == UnknownHabboCommunicationMessagesParserUserdefinedroomeventsWiredtradingTradeRequirementsRules1.UnknownVarFromUnknownHabboCommunicationMessagesParserUserdefinedroomeventsWiredtradingTradeRequirementsRules1_Int_3 && _loc1_ > 1)
            {
               requirementsMetHtml.text = localization.getLocalizationWithParams("inventory.wired_trading.requirements.indicator.met_numbered","","amount",_loc1_);
            }
            else
            {
               requirementsMetHtml.text = localization.getLocalization("inventory.wired_trading.requirements.indicator.met");
            }
         }
         else
         {
            requirementsMetHtml.text = localization.getLocalization("inventory.wired_trading.requirements.indicator.not_met");
         }
         resizeHtml(requirementsMetHtml);
         requirementsMetIcon.assetUri = _loc2_ ? "common_check_mark" : "common_cross_mark";
         additionalTextHtml.visible = false;
         if(UnknownVarFromWiredTradeRequirementsView_TradeRequirement_1.rules != null && UnknownVarFromWiredTradeRequirementsView_TradeRequirement_1.rules.type == UnknownHabboCommunicationMessagesParserUserdefinedroomeventsWiredtradingTradeRequirementsRules1.UnknownVarFromUnknownHabboCommunicationMessagesParserUserdefinedroomeventsWiredtradingTradeRequirementsRules1_Int_3)
         {
            additionalTextHtml.visible = true;
            _loc3_ = UnknownVarFromWiredTradeRequirementsView_TradeRequirement_1.isPaymentOnly() ? "inventory.wired_trading.requirements.auto_mode_hint_payment" : "inventory.wired_trading.requirements.auto_mode_hint_trade";
            additionalTextHtml.text = localization.getLocalizationWithParams(_loc3_,"","amount",UnknownVarFromWiredTradeRequirementsView_TradeRequirement_1.rules.autoMultiplierMax);
            resizeHtml(additionalTextHtml);
         }
         resizeRequirementContainers();
         recenter();
      }
      
      private function resizeHtml(param1:IHTMLTextController) : void
      {
         param1.height = param1.numLines * 15 + 2;
      }
      
      private function initializeStretchingWithParent(param1:IWindowController_1, param2:Boolean = true) : void
      {
         if(param2)
         {
            param1.width = param1.parent.width;
            param1.height = param1.parent.height;
         }
         param1.setParamFlag(128,param2);
         param1.setParamFlag(2048,param2);
      }
      
      public function get tradingModel() : WiredTradingModel
      {
         return UnknownVarFromWiredTradeRequirementsView_WiredTradeRequirementsModel_1.tradingModel;
      }
      
      private function get localization() : IHabboLocalizationManager
      {
         return tradingModel.localization;
      }
      
      public function highlightRefresh() : void
      {
         highlight();
      }
      
      private function highlight() : void
      {
         var border:UnknownICoreWindowComponents6;
         var transitionDuration:Number;
         var delay:int;
         var steps:int;
         var minValue:Number;
         var maxValue:Number;
         var updateValue:* = function(param1:TimerEvent):void
         {
            var _loc2_:Number = easeInOutCubic(_transitionTimer.currentCount,minValue,maxValue - minValue,steps);
            border.blend = _loc2_;
         };
         var onTimerComplete:* = function(param1:TimerEvent):void
         {
            border.visible = false;
         };
         if(_transitionTimer != null && _transitionTimer.running)
         {
            _transitionTimer.stop();
         }
         border = highlightBorder;
         transitionDuration = 500;
         delay = 16;
         steps = transitionDuration / delay;
         minValue = 0;
         maxValue = 0.35;
         border.visible = true;
         border.blend = 0;
         if(_transitionTimer != null)
         {
            _transitionTimer.reset();
         }
         else
         {
            _transitionTimer = new Timer(delay,steps);
            _transitionTimer.addEventListener("timer",updateValue);
            _transitionTimer.addEventListener("timerComplete",onTimerComplete);
         }
         _transitionTimer.start();
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         clear();
         if(_transitionTimer != null)
         {
            _transitionTimer.reset();
            _transitionTimer = null;
         }
         youGiveContainer.addChild(_offeringsTemplate);
         _offeringsTemplate = null;
         _bubble = null;
         UnknownVarFromWiredTradeRequirementsView_WiredTradeRequirementsModel_1 = null;
         UnknownVarFromWiredTradeRequirementsView_TradeRequirement_1 = null;
         _offeringBorderMargins = 0;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get bubbleTitle() : ITextWindow
      {
         return _bubble.findChildByName("bubble_title") as ITextWindow;
      }
      
      public function get highlightBorder() : UnknownICoreWindowComponents6
      {
         return _bubble.findChildByName("highlight_border") as UnknownICoreWindowComponents6;
      }
      
      public function get youGiveContainer() : IWindowController_1
      {
         return _bubble.findChildByName("you_give_container") as IWindowController_1;
      }
      
      public function get offeringContainersSeparator() : IWidgetWindowController
      {
         return _bubble.findChildByName("offering_containers_separator") as IWidgetWindowController;
      }
      
      public function get youGetContainer() : IWindowController_1
      {
         return _bubble.findChildByName("you_get_container") as IWindowController_1;
      }
      
      public function get requirementsMetContainer() : IWindowController_1
      {
         return _bubble.findChildByName("requirements_met_container") as IWindowController_1;
      }
      
      public function get requirementsMetHtml() : IHTMLTextController
      {
         return _bubble.findChildByName("req_met_text") as IHTMLTextController;
      }
      
      public function get requirementsMetIcon() : IStaticBitmapWrapperWindow
      {
         return _bubble.findChildByName("req_met_icon") as IStaticBitmapWrapperWindow;
      }
      
      public function get additionalTextHtml() : IHTMLTextController
      {
         return _bubble.findChildByName("additional_text") as IHTMLTextController;
      }
      
      public function get disclaimerTextHtml() : IHTMLTextController
      {
         return _bubble.findChildByName("disclaimer_text") as IHTMLTextController;
      }
   }
}

