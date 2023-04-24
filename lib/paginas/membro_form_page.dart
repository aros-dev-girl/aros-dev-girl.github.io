import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiara/modelos/membro.dart';
import 'package:tiara/modelos/membro_lista.dart';

class MembroFormPage extends StatefulWidget {
  const MembroFormPage({Key? key}) : super(key: key);

  @override
  State<MembroFormPage> createState() => _MembroFormPageState();
}

class _MembroFormPageState extends State<MembroFormPage> {
  final _nomeVerdadeiroFocus = FocusNode();
  final _posicaoFocus = FocusNode();
  final _dataNascimentoFocus = FocusNode();
  final _signoFocus = FocusNode();
  final _alturaFocus = FocusNode();

  final _imageUrlFocus = FocusNode();
  final _imageUrl1Controller = TextEditingController();
  final _imageUrl2Controller = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _formData = <String, Object>{};

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _imageUrlFocus.addListener(updateImage);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_formData.isEmpty) {
      final arg = ModalRoute.of(context)?.settings.arguments;

      if (arg != null) {
        final membro = arg as Membro;
        _formData['id'] = membro.id;
        _formData['nomeArtistico'] = membro.nomeArtistico;
        _formData['nomeVerdadeiro'] = membro.nomeVerdadeiro;
        _formData['posicao'] = membro.posicao;
        _formData['dataNascimento'] = membro.dataNascimento;
        _formData['signo'] = membro.signo;
        _formData['altura'] = membro.altura;
        _formData['imageUrl_1'] = membro.imageUrl_1;
        _formData['imageUrl_2'] = membro.imageUrl_2;

        _imageUrl1Controller.text = membro.imageUrl_1;
        _imageUrl2Controller.text = membro.imageUrl_2;
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _nomeVerdadeiroFocus.dispose();
    _posicaoFocus.dispose();
    _dataNascimentoFocus.dispose();
    _signoFocus.dispose();
    _alturaFocus.dispose();

    _imageUrlFocus.removeListener(updateImage);
    _imageUrlFocus.dispose();
  }

  void updateImage() {
    setState(() {});
  }

  bool isValidImageUrl(String url) {
    bool isValidUrl = Uri.tryParse(url)?.hasAbsolutePath ?? false;
    bool endsWithFile = url.toLowerCase().endsWith('.png') ||
        url.toLowerCase().endsWith('.jpg') ||
        url.toLowerCase().endsWith('.jpeg');
    return isValidUrl && endsWithFile;
  }

  Future<void> _submitForm() async {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    _formKey.currentState?.save();

    setState(() => _isLoading = true);

    try {
      await Provider.of<MembroLista>(
        context,
        listen: false,
      ).saveMember(_formData);

      Navigator.of(context).pop();
    } catch (error) {
      await showDialog<void>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Ocorreu um erro!'),
          content: const Text('Ocorreu um erro para salvar o membro.'),
          actions: [
            TextButton(
              child: const Text('Ok'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulário de Membro'),
        actions: [
          IconButton(
            onPressed: _submitForm,
            icon: const Icon(Icons.save),
          )
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(15),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    TextFormField(
                      initialValue: _formData['nomeArtistico']?.toString(),
                      decoration:
                          const InputDecoration(labelText: 'Nome Artístico'),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context)
                            .requestFocus(_nomeVerdadeiroFocus);
                      },
                      onSaved: (nomeArtistico) =>
                          _formData['nomeArtistico'] = nomeArtistico ?? '',
                      validator: (_nomeArtistico) {
                        final nomeArtistico = _nomeArtistico ?? '';
                        if (nomeArtistico.trim().isEmpty) {
                          return 'Nome artístico é obrigatório.';
                        }
                        if (nomeArtistico.trim().length < 3) {
                          return 'Nome artístico precisa no mínimo de 3 letras.';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      initialValue: _formData['nomeVerdadeiro']?.toString(),
                      decoration:
                          const InputDecoration(labelText: 'Nome Verdadeiro'),
                      focusNode: _nomeVerdadeiroFocus,
                      keyboardType: TextInputType.multiline,
                      onSaved: (nomeVerdadeiro) =>
                          _formData['nomeVerdadeiro'] = nomeVerdadeiro ?? '',
                      validator: (_nomeVerdadeiro) {
                        final nomeVerdadeiro = _nomeVerdadeiro ?? '';

                        if (nomeVerdadeiro.trim().isEmpty) {
                          return 'Nome verdadeiro é obrigatório.';
                        }

                        if (nomeVerdadeiro.trim().length < 10) {
                          return 'Nome verdadeiro precisa no mínimo de 10 letras.';
                        }

                        return null;
                      },
                    ),
                    TextFormField(
                      initialValue: _formData['posicao']?.toString(),
                      decoration: const InputDecoration(labelText: 'Posição'),
                      focusNode: _posicaoFocus,
                      keyboardType: TextInputType.multiline,
                      onSaved: (posicao) =>
                          _formData['posicao'] = posicao ?? '',
                      validator: (_posicao) {
                        final posicao = _posicao ?? '';

                        if (posicao.trim().isEmpty) {
                          return 'Posição é obrigatória.';
                        }

                        if (posicao.trim().length < 10) {
                          return 'Posição precisa no mínimo de 10 letras.';
                        }

                        return null;
                      },
                    ),
                    TextFormField(
                      initialValue: _formData['dataNascimento']?.toString(),
                      decoration: const InputDecoration(
                          labelText: 'Data de Nascimento'),
                      focusNode: _dataNascimentoFocus,
                      keyboardType: TextInputType.multiline,
                      onSaved: (dataNascimento) =>
                          _formData['dataNascimento'] = dataNascimento ?? '',
                      validator: (_dataNascimento) {
                        final dataNascimento = _dataNascimento ?? '';

                        if (dataNascimento.trim().isEmpty) {
                          return 'Data de nascimento é obrigatória.';
                        }

                        if (dataNascimento.trim().length < 10) {
                          return 'Data de nascimento precisa no mínimo de 10 letras.';
                        }

                        return null;
                      },
                    ),
                    TextFormField(
                      initialValue: _formData['signo']?.toString(),
                      decoration: const InputDecoration(labelText: 'Signo'),
                      focusNode: _signoFocus,
                      keyboardType: TextInputType.multiline,
                      onSaved: (signo) => _formData['signo'] = signo ?? '',
                      validator: (_signo) {
                        final signo = _signo ?? '';

                        if (signo.trim().isEmpty) {
                          return 'Signo é obrigatório.';
                        }

                        if (signo.trim().length < 5) {
                          return 'Signo precisa no mínimo de 5 letras.';
                        }

                        return null;
                      },
                    ),
                    TextFormField(
                      initialValue: _formData['altura']?.toString(),
                      decoration: const InputDecoration(labelText: 'Altura'),
                      textInputAction: TextInputAction.next,
                      focusNode: _alturaFocus,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                        signed: true,
                      ),
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_alturaFocus);
                      },
                      onSaved: (altura) =>
                          _formData['altura'] = double.parse(altura ?? '0'),
                      validator: (_altura) {
                        final alturaString = _altura ?? '';
                        final altura = double.tryParse(alturaString) ?? -1;

                        if (altura <= 0) {
                          return 'Informe uma altura válida.';
                        }

                        return null;
                      },
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration: const InputDecoration(
                                labelText: 'Url da Imagem 1'),
                            keyboardType: TextInputType.url,
                            textInputAction: TextInputAction.done,
                            focusNode: _imageUrlFocus,
                            controller: _imageUrl1Controller,
                            onFieldSubmitted: (_) => _submitForm(),
                            onSaved: (imageUrl) =>
                                _formData['imageUrl_1'] = imageUrl ?? '',
                            validator: (_imageUrl) {
                              final imageUrl = _imageUrl ?? '';

                              if (!isValidImageUrl(imageUrl)) {
                                return 'Informe uma Url válida!';
                              }

                              return null;
                            },
                          ),
                        ),
                        Container(
                          height: 100,
                          width: 100,
                          margin: const EdgeInsets.only(
                            top: 10,
                            left: 10,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 1,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: _imageUrl1Controller.text.isEmpty
                              ? const Text('Informe a Url 1')
                              : Image.network(_imageUrl1Controller.text),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration: const InputDecoration(
                                labelText: 'Url da Imagem 2'),
                            keyboardType: TextInputType.url,
                            textInputAction: TextInputAction.done,
                            focusNode: _imageUrlFocus,
                            controller: _imageUrl1Controller,
                            onFieldSubmitted: (_) => _submitForm(),
                            onSaved: (imageUrl) =>
                                _formData['imageUrl_2'] = imageUrl ?? '',
                            validator: (_imageUrl) {
                              final imageUrl = _imageUrl ?? '';

                              if (!isValidImageUrl(imageUrl)) {
                                return 'Informe uma Url válida!';
                              }

                              return null;
                            },
                          ),
                        ),
                        Container(
                          height: 100,
                          width: 100,
                          margin: const EdgeInsets.only(
                            top: 10,
                            left: 10,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 1,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: _imageUrl2Controller.text.isEmpty
                              ? const Text('Informe a Url 2')
                              : Image.network(_imageUrl2Controller.text),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
