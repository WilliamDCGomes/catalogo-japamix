import 'package:catalago_japamix/app/modules/login/page/login_page_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../../../../base/models/addressInformation/address_information.dart';
import '../../../../base/services/consult_cep_service.dart';
import '../../../../base/services/interfaces/iconsult_cep_service.dart';
import '../../../utils/helpers/brazil_address_informations.dart';
import '../../../utils/helpers/internet_connection.dart';
import '../../../utils/helpers/loading.dart';
import '../../../utils/helpers/masks_for_text_fields.dart';
import '../../../utils/helpers/valid_cellphone_mask.dart';
import '../../../utils/sharedWidgets/loading_with_success_or_error_widget.dart';
import '../../../utils/sharedWidgets/popups/information_popup.dart';
import '../widgets/body_register_stepper_widget.dart';
import '../widgets/header_register_stepper_widget.dart';

class RegisterUserController extends GetxController {
  late String lgpdPhrase;
  late RxInt activeStep;
  late RxBool passwordFieldEnabled;
  late RxBool loadingAnimation;
  late RxBool confirmPasswordFieldEnabled;
  late RxBool nameInputHasError;
  late RxBool birthdayInputHasError;
  late RxBool cpfInputHasError;
  late RxBool cepInputHasError;
  late RxBool cityInputHasError;
  late RxBool streetInputHasError;
  late RxBool neighborhoodInputHasError;
  late RxBool phoneInputHasError;
  late RxBool cellPhoneInputHasError;
  late RxBool emailInputHasError;
  late RxBool confirmEmailInputHasError;
  late RxBool passwordInputHasError;
  late RxBool confirmPasswordInputHasError;
  late RxString ufSelected;
  late RxString genderSelected;
  late List<String> genderList;
  late RxList<String> ufsList;
  late final GlobalKey<FormState> formKeyPersonalInformation;
  late final GlobalKey<FormState> formKeyAddressInformation;
  late final GlobalKey<FormState> formKeyContactInformation;
  late final GlobalKey<FormState> formKeyPasswordInformation;
  late MaskTextInputFormatter maskCellPhoneFormatter;
  late TextEditingController nameTextController;
  late TextEditingController birthDateTextController;
  late TextEditingController cpfTextController;
  late TextEditingController cepTextController;
  late TextEditingController cityTextController;
  late TextEditingController streetTextController;
  late TextEditingController houseNumberTextController;
  late TextEditingController neighborhoodTextController;
  late TextEditingController complementTextController;
  late TextEditingController phoneTextController;
  late TextEditingController cellPhoneTextController;
  late TextEditingController emailTextController;
  late TextEditingController confirmEmailTextController;
  late TextEditingController passwordTextController;
  late TextEditingController confirmPasswordTextController;
  late FocusNode birthDateFocusNode;
  late FocusNode cpfFocusNode;
  late FocusNode streetFocusNode;
  late FocusNode houseNumberFocusNode;
  late FocusNode neighborhoodFocusNode;
  late FocusNode complementFocusNode;
  late FocusNode cellPhoneFocusNode;
  late FocusNode emailFocusNode;
  late FocusNode confirmEmailFocusNode;
  late FocusNode confirmPasswordFocusNode;
  late List<HeaderRegisterStepperWidget> headerRegisterStepperList;
  late List<BodyRegisterStepperWidget> bodyRegisterStepperList;
  late LoadingWithSuccessOrErrorWidget loadingWithSuccessOrErrorWidget;
  late IConsultCepService _consultCepService;

  RegisterUserController(){
    _initializeVariables();
  }

  @override
  void onInit() async {
    await _getUfsNames();
    super.onInit();
  }

  _initializeVariables(){
    lgpdPhrase = "Ao avançar, você esta de acordo e concorda com as Políticas de Privacidade e com os Termos de Serviço.";
    activeStep = 0.obs;
    ufSelected = "".obs;
    genderSelected = "".obs;
    loadingAnimation = false.obs;
    passwordFieldEnabled = true.obs;
    confirmPasswordFieldEnabled = true.obs;
    nameInputHasError = false.obs;
    birthdayInputHasError = false.obs;
    cpfInputHasError = false.obs;
    cepInputHasError = false.obs;
    cityInputHasError = false.obs;
    streetInputHasError = false.obs;
    neighborhoodInputHasError = false.obs;
    phoneInputHasError = false.obs;
    cellPhoneInputHasError = false.obs;
    emailInputHasError = false.obs;
    confirmEmailInputHasError = false.obs;
    passwordInputHasError = false.obs;
    confirmPasswordInputHasError = false.obs;
    ufsList = [""].obs;
    genderList = [
      "Masculino",
      "Feminino",
    ];
    maskCellPhoneFormatter = MasksForTextFields.phoneNumberAcceptExtraNumberMask;
    formKeyPersonalInformation = GlobalKey<FormState>();
    formKeyAddressInformation = GlobalKey<FormState>();
    formKeyContactInformation = GlobalKey<FormState>();
    formKeyPasswordInformation = GlobalKey<FormState>();
    nameTextController = TextEditingController();
    birthDateTextController = TextEditingController();
    cpfTextController = TextEditingController();
    cepTextController = TextEditingController();
    cityTextController = TextEditingController();
    streetTextController = TextEditingController();
    houseNumberTextController = TextEditingController();
    neighborhoodTextController = TextEditingController();
    complementTextController = TextEditingController();
    phoneTextController = TextEditingController();
    cellPhoneTextController = TextEditingController();
    emailTextController = TextEditingController();
    confirmEmailTextController = TextEditingController();
    passwordTextController = TextEditingController();
    confirmPasswordTextController = TextEditingController();
    birthDateFocusNode = FocusNode();
    cpfFocusNode = FocusNode();
    streetFocusNode = FocusNode();
    houseNumberFocusNode = FocusNode();
    neighborhoodFocusNode = FocusNode();
    complementFocusNode = FocusNode();
    cellPhoneFocusNode = FocusNode();
    emailFocusNode = FocusNode();
    confirmEmailFocusNode = FocusNode();
    confirmPasswordFocusNode = FocusNode();
    loadingWithSuccessOrErrorWidget = LoadingWithSuccessOrErrorWidget();
    headerRegisterStepperList = const [
      HeaderRegisterStepperWidget(
        firstText: "PASSO 1 DE 4",
        secondText: "Dados Pessoais",
        thirdText: "Informe os dados pessoais para continuar o cadastro.",
      ),
      HeaderRegisterStepperWidget(
        firstText: "PASSO 2 DE 4",
        secondText: "Endereço",
        thirdText: "Informe os dados do seu endereço para continuar o cadastro.",
      ),
      HeaderRegisterStepperWidget(
        firstText: "PASSO 3 DE 4",
        secondText: "Dados de Contato",
        thirdText: "Preencha os dados de contato para que seja possível a comunicação.",
      ),
      HeaderRegisterStepperWidget(
        firstText: "PASSO 4 DE 4",
        secondText: "Senha de Acesso",
        thirdText: "Crie uma senha para realizar o acesso na plataforma.",
      ),
    ];
    bodyRegisterStepperList = [
      BodyRegisterStepperWidget(
        indexView: 0,
        controller: this,
      ),
      BodyRegisterStepperWidget(
        indexView: 1,
        controller: this,
      ),
      BodyRegisterStepperWidget(
        indexView: 2,
        controller: this,
      ),
      BodyRegisterStepperWidget(
        indexView: 3,
        controller: this,
      ),
    ];
    _consultCepService = ConsultCepService();
  }

  searchAddressInformation() async {
    try{
      if(cepTextController.text.length == 9){
        AddressInformation? addressInformation = await _consultCepService.searchCep(cepTextController.text);
        if(addressInformation != null){
          ufSelected.value = addressInformation.uf;
          cityTextController.text = addressInformation.city;
          streetTextController.text = addressInformation.street;
          neighborhoodTextController.text = addressInformation.neighborhood;
          complementTextController.text = addressInformation.complement;
          formKeyAddressInformation.currentState!.validate();
        }
        else{
          throw Exception();
        }
      }
    }
    catch(_){
      ufSelected.value = "";
      cityTextController.text = "";
      streetTextController.text = "";
      neighborhoodTextController.text = "";
      complementTextController.text = "";
    }
  }

  _getUfsNames() async {
    try{
      ufsList.clear();
      List<String> states = await BrazilAddressInformations.getUfsNames();
      for(var uf in states) {
        ufsList.add(uf);
      }
    }
    catch(_){
      ufsList.clear();
    }
  }

  _validPersonalInformationAndAdvanceNextStep() async {
    if(genderSelected.value.isEmpty){
      showDialog(
        context: Get.context!,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const InformationPopup(
            warningMessage: "Informe o seu sexo.",
          );
        },
      );
    }
    /*else if(await studentService.verificationStudentExists(cpfTextController.text)){
      showDialog(
        context: Get.context!,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const InformationPopup(
            warningMessage: "O CPF já está cadastrado no sistema.",
          );
        },
      );
    }*/
    else{
      /*newUser.name = nameTextController.text;
      newUser.birthdate = birthDateTextController.text;
      newUser.cpf = cpfTextController.text;
      newStudent.cpf = cpfTextController.text;
      newUser.gender = genderSelected.value;*/
      _nextPage();
    }
  }

  _validEmailAndAdvanceNextStep() async {
    if(false){//await studentService.verificationEmailExists(emailTextController.text)){
      showDialog(
        context: Get.context!,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const InformationPopup(
            warningMessage: "O E-mail já está cadastrado no sistema.",
          );
        },
      );
    }
    else{
      /*newUser.phone = phoneTextController.text;
      newUser.cellPhone = cellPhoneTextController.text;
      newUser.email = emailTextController.text;*/
      _nextPage();
    }
  }

  _nextPage() async {
    if(activeStep.value < 3) {
      activeStep.value ++;
    } else {
      await _saveUser();
    }
  }

  _saveUser() async {
    FocusScope.of(Get.context!).requestFocus(FocusNode());
    loadingAnimation.value = true;
    await loadingWithSuccessOrErrorWidget.startAnimation();

    await Future.delayed(const Duration(seconds: 1));

    try{
      await loadingWithSuccessOrErrorWidget.stopAnimation();
      await showDialog(
        context: Get.context!,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const InformationPopup(
            warningMessage: "Cadastro realizado com sucesso!",
            success: true,
          );
        },
      );
      Get.offAll(() => const LoginPage());
    }
    catch(_){
      await loadingWithSuccessOrErrorWidget.stopAnimation(fail: true);
      await showDialog(
        context: Get.context!,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const InformationPopup(
            warningMessage: "Erro ao cadastrar usuário.\n Tente novamente mais tarde",
          );
        },
      );
    }
  }

  nextButtonPressed() async {
    if(!await InternetConnection.validInternet(
      "É necessário uma conexão com a internet para fazer o cadastro",
      loadingWithSuccessOrErrorWidget,
    )){
      return;
    }
    switch(activeStep.value){
      case 0:
        if(formKeyPersonalInformation.currentState!.validate()){
          await Loading.startAndPauseLoading(
            () => _validPersonalInformationAndAdvanceNextStep(),
            loadingWithSuccessOrErrorWidget,
          );
        }
        break;
      case 1:
        if(formKeyAddressInformation.currentState!.validate()){
          /*newUser.cep = cepTextController.text;
          newUser.uf = ufSelected.value;
          newUser.city = cityTextController.text;
          newUser.street = streetTextController.text;
          newUser.houseNumber = houseNumberTextController.text;
          newUser.neighborhood = neighborhoodTextController.text;
          newUser.complement = complementTextController.text;*/
          _nextPage();
        }
        break;
      case 2:
        if(formKeyContactInformation.currentState!.validate()){
          Loading.startAndPauseLoading(
            () => _validEmailAndAdvanceNextStep(),
            loadingWithSuccessOrErrorWidget,
          );
        }
        break;
      case 3:
        if(formKeyPasswordInformation.currentState!.validate()){
          //newStudent.password = passwordTextController.text;
          _nextPage();
        }
        break;
    }
  }

  backButtonPressed() async {
    int currentIndex = activeStep.value;
    if (activeStep.value > 0) {
      activeStep.value--;
    }

    return await Future.delayed(
      const Duration(
          milliseconds: 100
      ),
      () {
        return currentIndex <= 0;
      }
    );
  }

  backButtonOverridePressed() {
    if (activeStep.value > 0) {
      activeStep.value--;
    }
    else {
      Get.back();
    }
  }

  phoneTextFieldEdited(String cellPhoneTyped){
    cellPhoneTextController.value = ValidCellPhoneMask.updateCellPhoneMask(
      cellPhoneTyped,
      maskCellPhoneFormatter,
    );
  }
}