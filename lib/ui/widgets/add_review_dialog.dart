import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:places/data/api_service.dart';
import 'package:places/domain/providers.dart';

class AddReviewDialog extends ConsumerStatefulWidget {
  final int placeId;

  const AddReviewDialog({required this.placeId, super.key});

  @override
  ConsumerState<AddReviewDialog> createState() => _AddReviewDialogState();
}

class _AddReviewDialogState extends ConsumerState<AddReviewDialog> {
  final _controller = TextEditingController();
  int _stars = 3;
  bool _sending = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_controller.text.trim().isEmpty) return;

    final token = ref.read(authProvider).token;
    if (token == null) return;

    setState(() => _sending = true);

    final ok = await ApiService.postReview(
      widget.placeId,
      _controller.text.trim(),
      _stars,
      token,
    );

    if (!mounted) return;

    if (ok) {
      // Refrescar la lista de reviews
      ref.invalidate(reviewsProvider(widget.placeId));
      Navigator.of(context).pop(true);
    } else {
      setState(() => _sending = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error al enviar la reseña')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xFF1E1E38),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Nueva Reseña',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
                fontFamily: 'Lato',
              ),
            ),
            const SizedBox(height: 20),

            // ─── Estrellas seleccionables ─────────────────────────────
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (i) {
                final starNum = i + 1;
                return IconButton(
                  icon: Icon(
                    starNum <= _stars ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                    size: 36,
                  ),
                  onPressed: () => setState(() => _stars = starNum),
                );
              }),
            ),
            const SizedBox(height: 8),
            Text(
              '$_stars de 5 estrellas',
              style: const TextStyle(color: Colors.white70, fontFamily: 'Lato'),
            ),
            const SizedBox(height: 16),

            // ─── Campo de texto ──────────────────────────────────────
            TextField(
              controller: _controller,
              maxLines: 3,
              style: const TextStyle(color: Colors.white, fontFamily: 'Lato'),
              decoration: InputDecoration(
                hintText: 'Escribe tu opinión...',
                hintStyle: const TextStyle(color: Colors.white38),
                filled: true,
                fillColor: Colors.white.withOpacity(0.08),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // ─── Botones ─────────────────────────────────────────────
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: _sending ? null : () => Navigator.of(context).pop(),
                  child: const Text(
                    'Cancelar',
                    style: TextStyle(color: Colors.white54, fontFamily: 'Lato'),
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: _sending ? null : _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF574ACF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: _sending
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text(
                          'Enviar',
                          style: TextStyle(color: Colors.white, fontFamily: 'Lato'),
                        ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
