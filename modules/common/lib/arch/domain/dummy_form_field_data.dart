import 'package:common/arch/domain/model/form_data.dart';
import 'package:common/arch/domain/model/img_data.dart';
import 'package:common/arch/ui/model/form_data.dart';
import 'package:common/config/_config.dart';
import 'package:common/res/string/_string.dart';
import 'package:common/value/const_values.dart';


final loginFormData = <FormGroupData>[
  FormGroupData(header: "header", data: [
    FormData(key: Const.KEY_EMAIL, question: Strings.email, type: FormType.text,),
    FormData(key: Const.KEY_PSWD, question: Strings.password, type: FormType.text,),
  ]),
];

final signupFormData = <FormGroupData>[
  FormGroupData(header: "header", data: [
    FormData(key: Const.KEY_NAME, question: Strings.name, type: FormType.text,),
    FormData(key: Const.KEY_EMAIL, question: Strings.email, type: FormType.text,),
    FormData(key: Const.KEY_PSWD, question: Strings.password, type: FormType.text,),
    FormData(key: Const.KEY_RE_PSWD, question: Strings.password_re, type: FormType.text,),
  ]),
];


final editFormData = <FormGroupData>[
  FormGroupData(header: "header", data: [
    FormData(key: Const.KEY_NAME, question: Strings.name, type: FormType.text,),
    FormData(key: Const.KEY_EMAIL, question: Strings.email, type: FormType.text,),
    FormData(key: Const.KEY_OLD_PSWD, question: Strings.old_password, type: FormType.text,),
    FormData(key: Const.KEY_PSWD, question: Strings.password, type: FormType.text,),
    FormData(key: Const.KEY_RE_PSWD, question: Strings.password_re, type: FormType.text,),
  ]),
];


final motherFormData = <FormGroupData>[
  FormGroupData(header: "header", data: [
    FormData(key: Const.KEY_NAME_INDO, question: Strings.name, type: FormType.text,),
    FormData(key: Const.KEY_NIK, question: Strings.nik, type: FormType.text,),
    FormData(key: Const.KEY_SALARY, question: Strings.salary, type: FormType.text,),
    FormData(key: Const.KEY_JKN, question: Strings.jkn, type: FormType.text,),
    FormData(key: Const.KEY_FASKES1, question: Strings.faskes1, type: FormType.text,),
    FormData(key: Const.KEY_FASKES_RUJUKAN, question: Strings.faskes_rujukan, type: FormType.text,),
    FormData(key: Const.KEY_BLOOD_TYPE, question: Strings.blood_type, type: FormType.text,),
    FormData(key: Const.KEY_BIRTH_PLACE, question: Strings.birth_place, type: FormType.text,),
    FormData(key: Const.KEY_BIRTH_DATE, question: Strings.birth_date, type: FormType.text,),
    FormData(key: Const.KEY_EDUCATION, question: Strings.education, type: FormType.text,),
    FormData(key: Const.KEY_OCCUPANCY, question: Strings.occupancy, type: FormType.text,),
    FormData(key: Const.KEY_ADDRESS, question: Strings.address, type: FormType.text,),
    FormData(key: Const.KEY_PHONE, question: Strings.phone, type: FormType.text,),
    FormData(key: Const.KEY_PUSKESMAS_DOMISILI, question: Strings.puskesmas_domisili, type: FormType.text,),
    FormData(key: Const.KEY_COHORT_REG, question: Strings.cohort_no, type: FormType.text,),
  ]),
];

final fatherFormData = <FormGroupData>[
  FormGroupData(header: "header", data: [
    FormData(key: Const.KEY_NAME_INDO, question: Strings.name, type: FormType.text,),
    FormData(key: Const.KEY_NIK, question: Strings.nik, type: FormType.text,),
    FormData(key: Const.KEY_SALARY, question: Strings.salary, type: FormType.text,),
    FormData(key: Const.KEY_JKN, question: Strings.jkn, type: FormType.text,),
    FormData(key: Const.KEY_FASKES1, question: Strings.faskes1, type: FormType.text,),
    FormData(key: Const.KEY_FASKES_RUJUKAN, question: Strings.faskes_rujukan, type: FormType.text,),
    FormData(key: Const.KEY_BLOOD_TYPE, question: Strings.blood_type, type: FormType.text,),
    FormData(key: Const.KEY_BIRTH_PLACE, question: Strings.birth_place, type: FormType.text,),
    FormData(key: Const.KEY_BIRTH_DATE, question: Strings.birth_date, type: FormType.text,),
    FormData(key: Const.KEY_EDUCATION, question: Strings.education, type: FormType.text,),
    FormData(key: Const.KEY_OCCUPANCY, question: Strings.occupancy, type: FormType.text,),
    FormData(key: Const.KEY_ADDRESS, question: Strings.address, type: FormType.text,),
    FormData(key: Const.KEY_PHONE, question: Strings.phone, type: FormType.text,),
  ]),
];

final childFormData = <FormGroupData>[
  FormGroupData(header: "header", data: [
    FormData(key: Const.KEY_NAME_INDO, question: Strings.name, type: FormType.text,),
    FormData(key: Const.KEY_NIK, question: Strings.nik, type: FormType.text,),
    FormData(key: Const.KEY_JKN, question: Strings.jkn, type: FormType.text,),
    FormData(key: Const.KEY_BLOOD_TYPE, question: Strings.blood_type, type: FormType.text,),
    FormData(key: Const.KEY_BIRTH_PLACE, question: Strings.birth_place, type: FormType.text,),
    FormData(key: Const.KEY_BIRTH_DATE, question: Strings.birth_date, type: FormType.text,),
    FormData(key: Const.KEY_CHILD_ORDER, question: Strings.child_order, type: FormType.text,),
    FormData(key: Const.KEY_GENDER, question: Strings.gender, type: FormType.text,),
    FormData(key: Const.KEY_BIRTH_CERT_NO, question: Strings.birth_cert_no, type: FormType.text,),
    FormData(key: Const.KEY_JKN_START_DATE, question: Strings.jkn_start_date, type: FormType.text,),
    FormData(key: Const.KEY_BABY_COHORT_REG, question: Strings.baby_cohort_no, type: FormType.text,),
    FormData(key: Const.KEY_TODDLER_COHORT_REG, question: Strings.toddler_cohort_no, type: FormType.text,),
    FormData(key: Const.KEY_HOSPITAL_MEDIC_NO, question: Strings.hospital_medic_no, type: FormType.text,),
  ]),
];


List<FormGroupData> getBabyFormGroupData_dummy(int month) {
  final list = [babyFormGroupData_growth,babyFormGroupData2,];
  return list[month % list.length];
}

final babyFormGroupData_growth = <FormGroupData>[
  FormGroupData(
    header: "Form Pemeriksaan Pertumbuhan Bayi",
    data: [
      FormData(key: Const.KEY_DATE, question: "Tanggal Periksa", type: FormType.text,),
      FormData(key: Const.KEY_PLACE, question: "Tempat Periksa", type: FormType.text,),
      FormData(key: Const.KEY_CHECKER, question: "Nama Pemeriksa", type: FormType.text,),
      FormData(key: Const.KEY_AGE, question: "Usia Bayi", type: FormType.text,),
      FormData(key: Const.KEY_WEIGHT, question: "Berat Badan (kg)", type: FormType.text,),
      FormData(key: Const.KEY_HEIGHT, question: "Panjang/Tinggi Badan (cm)", type: FormType.text,),
      FormData(key: Const.KEY_HEAD_CIRCUM, question: "Lingkar Kepala (cm)", type: FormType.text,),
      FormData(key: Const.KEY_IMT, question: "IMT Bayi", type: FormType.text,),
    ],
  ),
];

final babyFormGroupData2 = <FormGroupData>[
  FormGroupData(
    header: "Form Pemeriksaan Pertumbuhan Bayi",
    data: [
      FormData(key: "key1", question: "Tanggal Periksa", type: FormType.text,),
      FormData(key: "key2", question: "Tempat Periksa", type: FormType.text,),
      FormData(key: "key3", question: "Nama Pemeriksa", type: FormType.text,),
      FormData(key: "key4", question: "Usia Bayi", type: FormType.text,),
      FormData(key: "key5", question: "Berat Badan (kg)", type: FormType.text,),
      FormData(key: "key6", question: "Panjang/Tinggi Badan (cm)", type: FormType.text,),
      FormData(key: "key7", question: "Lingkar Kepala (cm)", type: FormType.text,),
      FormData(key: "key8", question: "IMT Bayi", type: FormType.text,),
    ],
  ),
  FormGroupData(
    header: "Form Pemeriksaan Pertumbuhan Bayi",
    data: [
      FormData(key: "key9",
        question: "Pada waktu bayi telentang, apakah masing-masing lengan dan tungkai bergerak dengan mudah? (Jawab TIDAK bila salah satu atau kedua tungkai atau lengan bayi bergerak tak terarah/tak terkendali)", 
        type: FormType.radio,
        options: [
          FormOption(label: "Ya", isSelected: false),
          FormOption(label: "Tidak", isSelected: false),
        ],
      ),
      FormData(key: "key10",
        question: "Pada waktu bayi telentang apakah ia melihat dan menatap wajah anda? ",
        type: FormType.radio,
        options: [
          FormOption(label: "Ya", isSelected: false),
          FormOption(label: "Tidak", isSelected: false),
        ],
      ),
      FormData(key: "key11",
        question: "Apakah bayi dapat mengeluarkan suara-suara lain (ngoceh), disamping menangis?",
        type: FormType.radio,
        options: [
          FormOption(label: "Ya", isSelected: false),
          FormOption(label: "Tidak", isSelected: false),
        ],
      ),
      FormData(key: "key12",
        question: "Pada waktu bayi telentang, apakah ia dapat mengikuti gerakan anda dengan menggerakkan kepalanya dari kanan/kiri ke tengah?",
        type: FormType.radio,
        options: [
          FormOption(label: "Ya", isSelected: false),
          FormOption(label: "Tidak", isSelected: false),
        ],
        img: [
          ImgData(link: "pic_baby_head_side_to_middle.png", package: GlobalRoutes.bayiku, isLocal: true),
        ],
      ),
    ],
  ),
];

final babyNeonatalServicePages = [
  "0-6 Jam", "KN 1", "KN 2", "KN 3",
];
final babyFormGroupData_neonatal = <FormGroupData>[
  FormGroupData(
    header: "Kondisi",
    data: [
      FormData(key: Const.KEY_WEIGHT, question: "Berat Badan (kg)", type: FormType.text,),
      FormData(key: Const.KEY_HEIGHT, question: "Panjang/Tinggi Badan (cm)", type: FormType.text,),
      FormData(key: Const.KEY_HEAD_CIRCUM, question: "Lingkar Kepala (cm)", type: FormType.text,),
      FormData(key: "key1", question: "Inisiasi Menyusui Dini (IMD)", type: FormType.radio,
        options: [
          FormOption(label: "Sudah", isSelected: false),
          FormOption(label: "Belum", isSelected: false),
        ],
      ),
      FormData(key: "key2", question: "Vit K1", type: FormType.radio,
        options: [
          FormOption(label: "Sudah", isSelected: false),
          FormOption(label: "Belum", isSelected: false),
        ],
      ),
      FormData(key: "key3", question: "Salep/Tetes Mata", type: FormType.radio,
        options: [
          FormOption(label: "Sudah", isSelected: false),
          FormOption(label: "Belum", isSelected: false),
        ],
      ),
    ],
  ),
];

/*
JANGAN DIHAPUS
final babyFormGroupData_dummy = <FormGroupData>[
  FormGroupData(
    header: "Yuk cek",
    data: [
      FormData(key: "key1", question: "question 1", type: FormType.text,),
      FormData(key: "key2", question: "question 2", type: FormType.radio, options: [
        FormOption(label: "opsi 1", isSelected: false),
        FormOption(label: "opsi 2", isSelected: false),
      ]),
      FormData(key: "key3", question: "question 3", type: FormType.check, options: [
        FormOption(label: "opsi 1", isSelected: true),
        FormOption(label: "opsi 2", isSelected: false),
        FormOption(label: "opsi 3", isSelected: true),
      ]),
    ],
  ),
  FormGroupData(
    header: "Yuk cek ke 2",
    data: [
      FormData(key: "key1", question: "question 1.2.3", type: FormType.check,
        options: [
          FormOption(label: "opsi 1", isSelected: false),
          FormOption(label: "opsi 2", isSelected: false),
          FormOption(label: "opsi 3", isSelected: true),
          FormOption(label: "opsi 3", isSelected: false),
        ],
      ),
      FormData(key: "key2",
        question: "Pada waktu bayi telentang, apakah ia dapat mengikuti gerakan anda dengan menggerakkan kepalanya dari kanan/kiri ke tengah?",
        type: FormType.radio,
        options: [
          FormOption(label: "opsi 1", isSelected: false),
          FormOption(label: "opsi 2", isSelected: false),
        ],
        img: [
          ImgData(link: "pic_baby_head_side_to_middle.png", package: "bayiku", isLocal: true),
        ],
      ),
      FormData(key: "key3", question: "question 3", type: FormType.text, options: [
        FormOption(label: "opsi 1", isSelected: true),
        FormOption(label: "opsi 2", isSelected: false),
        FormOption(label: "opsi 3", isSelected: true),
      ],
        answer: "halo bun"
      ),
      FormData(key: "key4", question: "question 4", type: FormType.check, options: [
        FormOption(label: "opsi 1", isSelected: false),
        FormOption(label: "opsi 2", isSelected: false),
        FormOption(label: "opsi 3", isSelected: true),
        FormOption(label: "opsi 3", isSelected: false),
      ]),
    ],
  ),
];
 */



final motherFormGroupData = <FormGroupData>[
  FormGroupData(
    header: "Form Pemeriksaan Bunda",
    data: [
      FormData(key: Const.KEY_VISIT_DATE, question: Strings.visit_date, type: FormType.text,),
      FormData(key: Const.KEY_VISIT_PLACE, question: Strings.visit_place, type: FormType.text,),
      FormData(key: Const.KEY_CHECKER_NAME, question: Strings.checker_name, type: FormType.text,),
      FormData(key: Const.KEY_MOTHER_DIFFICULTY, question: Strings.mother_difficulty, type: FormType.text,),
      FormData(key: Const.KEY_PREGNANCY_AGE, question: Strings.pregnancy_age, type: FormType.text,),
      FormData(key: Const.KEY_BABY_GENDER, question: Strings.baby_gender, type: FormType.text,),
      FormData(key: Const.KEY_FUTURE_VISIT_DATE, question: Strings.future_visit_date, type: FormType.text,),
      FormData(key: Const.KEY_HPHT, question: Strings.hpht, type: FormType.text,),
      FormData(key: Const.KEY_HPL, question: Strings.hpl, type: FormType.text,),
      FormData(key: Const.KEY_WEIGHT, question: Strings.mother_weight, type: FormType.text,),
      FormData(key: Const.KEY_WEIGHT_DIFF, question: Strings.mother_weight_diff, type: FormType.text,),
      FormData(key: Const.KEY_HEIGHT, question: Strings.mother_height, type: FormType.text,),
      FormData(key: Const.KEY_TFU, question: Strings.tfu, type: FormType.text,),
      FormData(key: Const.KEY_DJJ, question: Strings.djj, type: FormType.text,),
      FormData(key: Const.KEY_SYSTOLIC_PRESSURE, question: Strings.systolic_pressure, type: FormType.text,),
      FormData(key: Const.KEY_DIASTOLIC_PRESSURE, question: Strings.diastolic_pressure, type: FormType.text,),
      FormData(key: Const.KEY_MAP, question: Strings.map, type: FormType.text,),
      FormData(key: Const.KEY_BABY_MOVEMENT, question: Strings.baby_movement, type: FormType.text,),
      FormData(key: Const.KEY_DRUG_PRESCRIPT, question: Strings.drug_prescript, type: FormType.text,),
      FormData(key: Const.KEY_DRUG_ALLERGY, question: Strings.drug_allergy, type: FormType.text,),
      FormData(key: Const.KEY_DISEASE_HISTORY, question: Strings.disease_history, type: FormType.text,),
      FormData(key: Const.KEY_SPECIAL_NOTE, question: Strings.special_note, type: FormType.text,),
    ],
  ),
];

final pregnancyImmunizationFormGroupData = <FormGroupData>[
  FormGroupData(
    header: "Konfirmasi Imunisasi",
    data: [
      FormData(key: Const.KEY_IMMUNIZATION_DATE, question: Strings.immunization_date, type: FormType.text,),
      FormData(key: Const.KEY_IMMUNIZATION_PLACE, question: Strings.immunization_place, type: FormType.text,),
      FormData(key: Const.KEY_RESPONSIBLE_NAME, question: Strings.responsible_name, type: FormType.text,),
    ],
  ),
];
final babyImmunizationFormGroupData = <FormGroupData>[
  FormGroupData(
    header: "Konfirmasi Imunisasi",
    data: [
      FormData(key: Const.KEY_IMMUNIZATION_DATE, question: Strings.immunization_date, type: FormType.text,),
      FormData(key: Const.KEY_IMMUNIZATION_PLACE, question: Strings.immunization_place, type: FormType.text,),
      FormData(key: Const.KEY_RESPONSIBLE_NAME, question: Strings.responsible_name, type: FormType.text,),
      FormData(key: Const.KEY_NO_BATCH, question: Strings.no_batch, type: FormType.text,),
    ],
  ),
];



final covidMotherCheckFormGroupData = <FormGroupData>[
  FormGroupData(
    header: "Form Pemeriksaan Gejala Covid-19",
    data: [
      FormData(key: "key1", question: "Apakah bayi mengalami demam atau ada riwayat demam?", type: FormType.radio,
        options: [
          FormOption(label: "Ya", isSelected: false),
          FormOption(label: "Tidak", isSelected: false),
        ],
      ),
      FormData(key: "key2", question: "Apakah bayi mengalami Gejala Gangguan pernapasan: Batuk/Pilek/Nyeri Tenggorokan, dll?", type: FormType.radio,
        options: [
          FormOption(label: "Ya", isSelected: false),
          FormOption(label: "Tidak", isSelected: false),
        ],
      ),
      FormData(key: "key3", question: "Apakah bayi mengidap penyakit Pneumonia Berat/ ISPA Berat?", type: FormType.radio,
        options: [
          FormOption(label: "Ya", isSelected: false),
          FormOption(label: "Tidak", isSelected: false),
        ],
      ),
    ],
  ),
];